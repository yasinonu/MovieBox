//
//  APIService.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import Foundation


struct APIService {
    private let baseURL: URL = URL(string: "https://moviatask.cerasus.app")!
    
    private let keychainHelper = KeychainHelper.shared
    
    static let shared: APIService = .init()
    
    // MARK: Authentication
    
    static var accessToken: String? = nil
    
    // Service and Account for Keychain
    private let service = "com.amogus.token"
    private let account = "accessToken"
    
    // Register User : Register a new user
    
    func registerUser(name: String, surname: String, email: String, password: String) async throws -> RegisterResponse {
        let body = RegisterRequestBody(name: name, surname: surname, email: email, password: password)
        
        let response: RegisterResponse = try await send(path: "api/auth/register", method: "POST", body: body, token: false)
        
        return response
    }
    
    // Login User : Login an existing user
    
    func loginUser(email: String, password: String) async throws -> RegisterResponse {
        let body = LoginRequestBody(email: email, password: password)
        
        let response: RegisterResponse = try await send(path: "api/auth/login", method: "POST", body: body, token: false)
        
        return response
    }
    
    // Fetch Me : Retrieve the current user's information
    
    func fetchMe() async throws -> User {
        let response: User = try await send(path: "api/auth/me", body: nil as String?)
        
        return response
    }
    
    // MARK: Movies
    
    // Get Movies : Retrieve a list of movies
    func fetchAllMovies() async throws -> [Movie] {
        let response: [Movie] = try await send(path: "api/movies", body: nil as String?, token: false)
        
        return response
    }
    
    // Get Movie : Retrieve a specific movie by ID
    func fetchMovieBy(id: String) async throws -> Movie {
        let response: Movie = try await send(path: "api/movies/\(id)", body: nil as String?, token: false)
        
        return response
    }
    
    // Like Movie : Like a specific movie by ID
    func likeMovie(id: Int) async throws -> MovieLikeResponse {
        let response: MovieLikeResponse = try await send(path: "api/movies/like/\(id)", method: "POST", body: nil as String?)
        
        return response
    }
    
    // Unlike Movie : Unlike a specific movie by ID
    func unlikeMovie(id: Int) async throws -> MovieLikeResponse {
        let response: MovieLikeResponse = try await send(path: "api/movies/unlike/\(id)", method: "POST", body: nil as String?)
        
        return response
    }
    
    // MARK: Users
    
    // Get Liked Movies : Retrieve a list of movies liked by the current user
    func fetchLikedMovies() async throws -> [Movie] {
        let response: [Movie] = try await send(path: "api/movies/liked-movies", body: nil as String?)
        
        return response
    }
    
    // Get Liked Movie IDs : Retrieve a list of movies liked by the current user
    func fetchLikedMovieIDs() async throws -> [Movie.ID] {
        let response: [Movie.ID] = try await send(path: "api/movies/liked-movie-ids", body: nil as String?)
        
        return response
    }
    
    // Update User Profile: Update the current user's profile information
    func updateUserProfile(name: String, surname: String, email: String, password: String) async throws -> UpdateUserProfileResponse {
        let body = UpdateUserRequestBody(name: name, surname: surname, email: email, password: password)
        
        let response: UpdateUserProfileResponse = try await send(path: "api/users/profile", method: "PUT", body: body)
        
        return response
    }
    
    
    // MARK: - Helpers
    
    // Save Access Token : Save the access token to Keychain
    public func save(accessToken: String) {
        keychainHelper.save(accessToken, service: service, account: account)
    }
    
    // Read Access Token : Retrieve the access token from Keychain
    public func readAccessToken() -> String? {
        keychainHelper.read(service: service, account: account)
    }
    
    // Delete Access Token : Delete the access token from Keychain
    public func deleteAccessToken() {
        keychainHelper.delete(service: service, account: account)
    }
    
    // Send Request : Send a request to the server
    private func send<Response: Decodable, RequestBody: Encodable>(path: String, method: String = "GET", body: RequestBody? = nil, token: Bool = true) async throws -> Response {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if token, let accessToken = Self.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let body {
            guard let httpBody = try? JSONEncoder().encode(body) else {
                throw AppError.encodingError
            }
            request.httpBody = httpBody
        }
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            print("Failed to fetch data from \(url)")
            throw AppError.networkError
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                print("Error Response: \(errorResponse)")
                throw AppError.custom(errorResponse.error)
            }
            else if let messageResponse = try? JSONDecoder().decode(MessageResponse.self, from: data) {
                print("Message Response: \(messageResponse)")
                throw AppError.custom(messageResponse.message)
            }
            else {
                throw AppError.networkError
            }
        }
        
        guard let responseData = try? JSONDecoder().decode(Response.self, from: data) else {
            print("Failed to decode response")
            throw AppError.decodingError
        }
        
        return responseData
    }
}
