//
//  FinancialAdviceCategory.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 15/12/2024.
//

import Foundation


enum FinancialAdviceCategory {
    case exchange
    case crypto
    case immovability
    case unknown
}

extension FinancialAdviceCategory {
    var prompt: String {
        switch self {
        case .exchange:
            return "As a user I want to take financial advices regarding exchanges, can you help me with elaborating more with assistant?"
        case .crypto:
            return "As a user I want to take financial advices regarding cryptocurrencies, can you help me with elaborating more with assistant?"
        case .immovability:
            return "As a user I want to take financial advices regarding immovability, can you help me with elaborating more with assistant?"
        case .unknown:
            return ""
        }
    }
}
