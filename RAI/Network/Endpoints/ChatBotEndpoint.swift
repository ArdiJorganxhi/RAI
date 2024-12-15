//
//  ChatBotEndpoint.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 14/12/2024.
//

import Foundation



enum ChatBotEndpoint {
    case trackIssue(request: IssueRequest)
    case chat(prompt: String)
    case financialAdvice(request: FinancialAdviceRequest)
}

extension ChatBotEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .trackIssue(_):
            return "/api/v1/track-issues"
        case .chat(_):
            return "/api/v1/chat"
        case .financialAdvice(_):
            return "/api/v1/process-chat"
        }
    }
    
    var port: Int {
        switch self {
        case .trackIssue(request: _):
            return 8080
        case .chat(prompt: _):
            return 8080
        case .financialAdvice(_):
            return 8002
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .chat(prompt: let prompt):
            return [URLQueryItem(name: "prompt", value: prompt)]
        case .trackIssue(_):
            return []
        case .financialAdvice(_):
            return []
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .trackIssue(_):
            return .POST
        case .chat(_):
            return .POST
        case .financialAdvice(_):
            return .POST
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .trackIssue(_):
            return ["Content-Type": "application/json"]
        case .chat(_):
            return ["Content-Type": "application/json"]
        case .financialAdvice(_):
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .trackIssue(let request):
            return try? JSONEncoder().encode(request)
        case .chat(_):
            return nil
        case .financialAdvice(let request):
            return try? JSONEncoder().encode(request)
        }
    }
}

