//
//  FinancialAdviceRequest.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 14/12/2024.
//

import Foundation

struct FinancialAdviceRequest: Encodable {
    var search: String
    
    init(search: String) {
        self.search = search + ", can you help me with elaborating more with assistant"
    }
}
