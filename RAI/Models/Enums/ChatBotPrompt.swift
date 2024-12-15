//
//  ChatBotPrompt.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 15/12/2024.
//

import Foundation



enum ChatBotPrompt {
    case welcomeUser(language: String)
    case askUserAboutFinancialCategories(language: String)
    case thankyouUser(language: String)
    case didntUnderstandUser(language: String)
}

extension ChatBotPrompt {
    var prompt: String {
        switch self {
        case .welcomeUser(let language):
            if(language == Language.english.rawValue) {
                return "Hello, Mr. Ardi! How may I help you?"
            } else {
                return "Pershendetje zoteri Ardi, si mund te ju ndihmojme?"
            }
        case .askUserAboutFinancialCategories(let language):
            if(language == Language.english.rawValue) {
                return "Hi, thanks for asking about financial advice. Can you specify which category do you want me to help you with? \n 1. Exchanges \n 2. Stocks \n 3. Bonds"
            } else {
                return "Pershendetje, faleminderit qe na keni pyetur per sygjerim financiar. A mund te kallxoni me hollesisht per cilen kategori jeni te interesuar? \n 1. Exchanges \n 2. Stocks \n 3. Bonds"
            }
        case .thankyouUser(language: let language):
            if(language == Language.english.rawValue) {
                return "Thank you! Please let me know if you have any other questions."
            } else {
                return "Faleminderit! Jemi gjithmone ne dispozicion per juve!"
            }
        case .didntUnderstandUser(language: let language):
            if(language == Language.english.rawValue) {
                return "I didn't understand your request. Can you clarify it with more details?"
            } else {
                return "Nuk e kam kuptuar kerkesen e juaj. A mund te kallxoni me hollesisht per cfare keni ndihme?"
            }
        }
    }
}
