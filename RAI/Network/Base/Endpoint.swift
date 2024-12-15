//
//  Endpoint.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 13/12/2024.
//


import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
    var path: String { get }
    var params: [URLQueryItem] { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: Data? { get }
    
}

extension Endpoint {
    var scheme: String {
        return "http"
    }
    var host: String {
        return "localhost"
    }
}
