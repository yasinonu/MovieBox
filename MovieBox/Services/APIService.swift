//
//  APIService.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import Foundation


struct APIService {
    let baseURL: URL = URL(string: "https://moviatask.cerasus.app")!
    
    // MARK: Authentication
    
    // Register User : Register a new user
    
    func registerUser(name: String, surname: String, email: String, password: String) async throws -> RegisterResponse {
        let body = RegisterRequestBody(name: name, surname: surname, email: email, password: password)
        
        let response: RegisterResponse = try await sendPOSTRequest(path: "api/auth/register", body: body)
        
        return response
    }
    
    func loginUser(email: String, password: String) async throws -> RegisterResponse {
        let body = LoginRequestBody(email: email, password: password)
        
        let response: RegisterResponse = try await sendPOSTRequest(path: "api/auth/login", body: body)
        
        return response
    }
    
    // MARK: - Helpers
    
    // Send Request : Send a request to the server
    private func send<Response: Decodable>(request: URLRequest, accessToken: String? = nil) async throws -> Response {
        var request = request
        
        if let accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let responseData = try JSONDecoder().decode(Response.self, from: data)
        
        return responseData
    }
}
