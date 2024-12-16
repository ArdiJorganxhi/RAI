//
//  ChatBotViewModel.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 14/12/2024.
//

import Foundation

@MainActor
final class ChatBotViewModel: ObservableObject {
    private var currentLanguage: Language = .albanian
    @Published var chats: [ChatMessage]
    @Published var isBotTyping: Bool = false
    @Published var currentTypingLanguage: Language = .albanian
    
    private let chatBotService: ChatBotServiceable
    
    init(chatBotService: ChatBotServiceable = ChatBotService()) {
        self.chatBotService = chatBotService
        self.chats = [
            ChatMessage(text: ChatBotPrompt.welcomeUser(language: self.currentLanguage.rawValue).prompt, isUser: false)
        ]
    }
    
    func getTextForTyping() -> String {
        if self.currentTypingLanguage == .english {
            return "RAI is typing..."
        } else {
            return "RAI eshte duke shkruar..."
        }
    }
    
    func chat(in message: String) {
        self.currentLanguage = detectLanguage(for: message)!
        self.currentTypingLanguage = self.currentLanguage
        self.chats.append(ChatMessage(text: message, isUser: true))
        switch message {
        case let str where str.contains(anyOf: technicalIssues):
            trackIssue(message: str)
        case let str where str.contains(anyOf: financialAdvices) || str.contains(anyOf: categoriesOfFinancialAdvices):
            if(str.lowercased().contains(anyOf: financialAdvices) && str.lowercased().contains(anyOf: categoriesOfFinancialAdvices)) {
                giveFinancialAdvice(message: str)
            }
            else if(str.contains(anyOf: categoriesOfFinancialAdvices)) {
                let userMessage = self.chats.index(before: self.chats.endIndex - 2)
                let category = str.extractFinancialAdviceCategory(userMessage: self.chats[userMessage].text)
                print("This is prompt for financial advice: " + category.prompt)
                giveFinancialAdvice(message: category.prompt)
            } else {
                self.isBotTyping = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isBotTyping = false
                    self.chats.append(ChatMessage(text: ChatBotPrompt.askUserAboutFinancialCategories(language: self.currentLanguage.rawValue).prompt, isUser: false))
                }
            }
        case let str where str.contains(anyOf: keywordsForThanking):
            self.isBotTyping = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isBotTyping = false
                self.chats.append(ChatMessage(text: ChatBotPrompt.thankyouUser(language: self.currentLanguage.rawValue).prompt, isUser: false))
        }

        default:
            self.isBotTyping = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isBotTyping = false
                self.chats.append(ChatMessage(text: ChatBotPrompt.didntUnderstandUser(language: self.currentLanguage.rawValue).prompt, isUser: false))
            }
            
        }
    }
    
    private func trackIssue(message: String) {
        self.isBotTyping = true
        let IssueRequest = IssueRequest(request: message, userId: "123")
        Task(priority: .background) {
            let response = await chatBotService.trackIssue(request: IssueRequest)
            print(response)
            switch response {
            case .success(let issue):
                DispatchQueue.main.async {
                    print(issue)
                    self.isBotTyping = false
                    self.chats.append(ChatMessage(text: issue.message, isUser: false))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func giveFinancialAdvice(message: String) {
        self.isBotTyping = true
        let financialRequest = FinancialAdviceRequest(search: message)
        print("This is financial advice question:" + financialRequest.search)
        Task(priority: .background) {
            let response = await chatBotService.giveFinancialAdvice(request: financialRequest)
            print(response)
            switch response {
            case .success(let financialAdvice):
                DispatchQueue.main.async {
                    self.isBotTyping = false
                    self.chats.append(ChatMessage(text: financialAdvice.message, isUser: false))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
