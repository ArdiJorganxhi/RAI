//
//  ChatMessage.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 12/12/2024.
//

import Foundation


struct ChatMessage: Identifiable {
    
    let id = UUID()
    let text: String
    let isUser: Bool
}
