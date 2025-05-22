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
        
        let response: RegisterResponse = try await sendRequest(path: "api/auth/register", method: "POST", body: body)
        
        return response
    }
    
    func loginUser(email: String, password: String) async throws -> RegisterResponse {
        let body = LoginRequestBody(email: email, password: password)
        
        let response: RegisterResponse = try await sendRequest(path: "api/auth/login", method: "POST", body: body)
        
        return response
    }
        
    
    // MARK: - Helpers
    
    // Send Request : Send a request to the server
    private func sendRequest<Response: Decodable, RequestBody: Encodable>(path: String, method: String = "GET", body: RequestBody? = nil) async throws -> Response {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let responseData = try JSONDecoder().decode(Response.self, from: data)
        
        return responseData
    }
}
