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
        ChatMessage(text: "Pershendetje zoteri Ardi, si mund te ju ndihmojme?", isUser: false)
    ]
    private let chatBotService: ChatBotServiceable
    
    init(chatBotService: ChatBotServiceable = ChatBotService()) {
        self.chatBotService = chatBotService
    }
    
    func chat(in message: String) {
        self.chats.append(ChatMessage(text: message, isUser: true))
        print("This is the message:" + message)
        switch message {
        case let str where str.contains(anyOf: ["problem", "vonese", "vonuar", "nuk", "ardh"]):
                let IssueRequest = IssueRequest(request: str, userId: "123")
                Task(priority: .background) {
                    let response = await chatBotService.trackIssue(request: IssueRequest)
                    print(response)
                    switch response {
                    case .success(let issue):
                        DispatchQueue.main.async {
                            print(issue)
                            self.chats.append(ChatMessage(text: issue.message, isUser: false))
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        case let str where str.contains(anyOf: ["financial", "advice"]):
            let financialRequest = FinancialAdviceRequest(search: str)
            Task(priority: .background) {
                let response = await chatBotService.giveFinancialAdvice(request: financialRequest)
                print(response)
                switch response {
                case .success(let financialAdvice):
                    DispatchQueue.main.async {
                        self.chats.append(ChatMessage(text: financialAdvice.message, isUser: false))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

            default:
                self.chats.append(ChatMessage(text: "Nuk e kuptoj kerkesen tuaj", isUser: false))
            }
    }
}
