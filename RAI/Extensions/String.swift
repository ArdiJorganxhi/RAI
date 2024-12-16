//
//  String.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 14/12/2024.
//

import Foundation


extension String {
    
    func contains(anyOf substrings: [String]) -> Bool {
        for substring in substrings {
            if(self.range(of: substring, options: .caseInsensitive) != nil) {return true}
        }
        return false
    }
    
    func extractFinancialAdviceCategory(userMessage: String) -> FinancialAdviceCategory {
        let category =  categoriesOfFinancialAdvices.filter {self.lowercased().contains($0.lowercased())}[0]
        print("Found category:" + category)
        switch category.lowercased() {
        case "bonds":
            return .bonds(message: userMessage, language: Language.english.rawValue)
        case "exchanges":
            return .exchange(message: userMessage, language: Language.english.rawValue)
        case "stocks":
            return .stocks(message: userMessage, language: Language.english.rawValue)
        case let str where ["stoqe", "stoqet"].contains(str):
            return .stocks(message: userMessage, language: Language.albanian.rawValue)
        case let str where ["shkembime", "shkembimet"].contains(str):
            return .exchange(message: userMessage, language: Language.albanian.rawValue)
        case let str where ["bonde", "bondet"].contains(str):
            return .bonds(message: userMessage, language: Language.albanian.rawValue)
        default:
            return .unknown
        }
    }
}
