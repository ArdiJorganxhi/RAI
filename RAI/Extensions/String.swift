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
    
    func extractFinancialAdviceCategory() -> FinancialAdviceCategory {
        let category =  categoriesOfFinancialAdvices.filter {self.lowercased().contains($0.lowercased())}[0]
        switch category {
        case "crypto":
            return .crypto
        case "exchanges":
            return .exchange
        case "immovability":
            return .immovability
        default:
            return .unknown
        }
    }
}
