//
//  ChatBotViewModel.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 14/12/2024.
//

import Foundation

@MainActor
final class ChatBotViewModel: ObservableObject {
    @Published var chats: [ChatMessage] = [
        ChatMessage(text: welcomeUser, isUser: false)
    ]
    @Published var isBotTyping: Bool = false
    
    private let chatBotService: ChatBotServiceable
    
    init(chatBotService: ChatBotServiceable = ChatBotService()) {
        self.chatBotService = chatBotService
    }
    
    func chat(in message: String) {
        self.chats.append(ChatMessage(text: message, isUser: true))
        switch message {
        case let str where str.contains(anyOf: technicalIssues):
            trackIssue(message: str)
        case let str where str.contains(anyOf: financialAdvices) || str.contains(anyOf: categoriesOfFinancialAdvices):
            if(str.contains(anyOf: categoriesOfFinancialAdvices)) {
                let category = str.extractFinancialAdviceCategory()
                giveFinancialAdvice(message: category.prompt)
            } else {
                self.isBotTyping = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isBotTyping = false
                    self.chats.append(ChatMessage(text: askUserAboutFinancialCategories, isUser: false))
                }
            }
        case let str where str.contains(anyOf: keywordsForThanking):
            self.chats.append(ChatMessage(text: thankyouUser, isUser: false))
            
        default:
            self.isBotTyping = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isBotTyping = false
                self.chats.append(ChatMessage(text: didntUnderstandUser, isUser: false))
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
