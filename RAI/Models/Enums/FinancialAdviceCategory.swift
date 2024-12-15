//
//  FinancialAdviceCategory.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 15/12/2024.
//

import Foundation


enum FinancialAdviceCategory {
    case exchange(message: String)
    case stocks(message: String)
    case bonds(message: String)
    case unknown
}

extension FinancialAdviceCategory {
    var prompt: String {
        switch self {
        case .exchange(let message):
            return message + " on exchange, please elaborate more with assistant"
        case .stocks(let message):
            return message + " on stocks, please elaborate more with assistant"
        case .bonds(let message):
            return message + " on bonds, please elaborate more with assistant"
        case .unknown:
            return ""
        }
    }
}
