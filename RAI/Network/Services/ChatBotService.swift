//
//  ChatBotService.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 14/12/2024.
//

import Foundation

struct ChatBotService: HTTPRequest, ChatBotServiceable {
    func trackIssue(request: IssueRequest) async -> Result<TrackIssueResponse, NetworkError> {
        return await sendRequest(endpoint: ChatBotEndpoint.trackIssue(request: request), response: TrackIssueResponse.self)
    }
    
    func chat(prompt: String) async -> Result<ChatResponse, NetworkError> {
        return await sendRequest(endpoint: ChatBotEndpoint.chat(prompt: prompt), response: ChatResponse.self)
    }
    
    func giveFinancialAdvice(request: FinancialAdviceRequest) async -> Result<FinancialAdviceResponse, NetworkError> {
        return await sendRequest(endpoint: ChatBotEndpoint.financialAdvice(request: request), response: FinancialAdviceResponse.self)
    }
    
    
}
