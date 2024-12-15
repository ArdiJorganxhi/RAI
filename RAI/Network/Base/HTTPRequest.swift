//
//  HTTPRequest.swift
//  RAI
//
//  Created by Ardi Jorganxhi on 13/12/2024.
//

import Foundation


protocol HTTPRequest {
    func sendRequest<T: Decodable>(endpoint: Endpoint, response: T.Type) async -> Result<T, NetworkError>
}

extension HTTPRequest {
    func sendRequest<T: Decodable>(endpoint: Endpoint, response: T.Type) async -> Result<T, NetworkError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.port = endpoint.port
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params
        
        guard let url = urlComponents.url else {
            print(urlComponents)
            return .failure(.invalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        print(request)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.custom(message: "No Data"))
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodeResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    return .failure(.decodingError)
                }
                return .success(decodeResponse)
            case 400...499:
                return .failure(.custom(message: "User error"))
            case 500...599:
                return .failure(.custom(message: "User error"))
            default:
                return .failure(.custom(message: "Unexpected error"))
            }
        } catch {
            return .failure(.custom(message: "Unknown error"))
        }
              
    }
}
