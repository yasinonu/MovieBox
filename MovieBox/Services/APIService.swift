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
    
    // Login User : Login an existing user
    
    func loginUser(email: String, password: String) async throws -> RegisterResponse {
        let body = LoginRequestBody(email: email, password: password)
        
        let response: RegisterResponse = try await sendPOSTRequest(path: "api/auth/login", body: body)
        
        return response
    }
    
    // Fetch Me : Retrieve the current user's information
    
    func fetchMe() async throws -> User {
        let accessToken = ""
        let response: User = try await sendGETRequest(path: "api/auth/me", accessToken: accessToken)
        
        return response
    }
    
    // MARK: - Helpers
    
    private func sendGETRequest<Response: Decodable>(path: String, accessToken: String? = nil) async throws -> Response {
        let url = baseURL.appendingPathComponent(path)
        
        let request = URLRequest(url: url)
        
        return try await send(request: request, accessToken: accessToken)
    }
    
    private func sendPOSTRequest<Response: Decodable, RequestBody: Encodable>(path: String, body: RequestBody, accessToken: String? = nil) async throws -> Response {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(body)
        
        return try await send(request: request, accessToken: accessToken)
    }
    
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
