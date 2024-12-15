//
//  ChatServiceable.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 14/12/2024.
//

import Foundation


protocol ChatBotServiceable {
    func trackIssue(request: IssueRequest) async -> Result<TrackIssueResponse, NetworkError>
    func chat(prompt: String) async -> Result<ChatResponse, NetworkError>
    func giveFinancialAdvice(request: FinancialAdviceRequest) async -> Result<FinancialAdviceResponse, NetworkError>
}
