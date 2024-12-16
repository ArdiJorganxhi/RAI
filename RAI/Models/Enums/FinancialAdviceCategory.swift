//
//  FinancialAdviceCategory.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 15/12/2024.
//

import Foundation


enum FinancialAdviceCategory {
    case exchange(message: String, language: String)
    case stocks(message: String, language: String)
    case bonds(message: String, language: String)
    case unknown
}

extension FinancialAdviceCategory {
    var prompt: String {
        switch self {
        case .exchange(let message, let language):
            if(language == Language.english.rawValue) {
                return message + " in exchanges, please elaborate more with assistant"
            } else {
                return message + " ne shkembim, te lutem elaboroma me shume duke perdour assistencen"
            }

        case .stocks(let message, let language):
            if(language == Language.english.rawValue) {
                return message + " in stocks, please elaborate more with assistant"
            } else {
                return message + " ne stoqe, te lutem elaboroma me shume duke perdour assistencen"
            }
        case .bonds(let message, let language):
            if(language == Language.english.rawValue) {
                return message + " in bonds, please elaborate more with assistant"
            } else {
                return message + " ne obligacionet, te lutem elaboroma me shume duke perdour assistencen"
            }
        case .unknown:
            return ""
        }
    }
}
