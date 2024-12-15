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
            return .bonds(message: userMessage)
        case "exchanges":
            return .exchange(message: userMessage)
        case "stocks":
            return .stocks(message: userMessage)
        default:
            return .unknown
        }
    }
}
