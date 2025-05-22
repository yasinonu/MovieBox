//
//  AuthViewModel.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    private let apiService: APIService = .init()
    
    // Register user
    
    public func registerUser(name: String, surname: String, email: String, password: String) async {
        do {
            let response = try await apiService.registerUser(name: name, surname: surname, email: email, password: password)
        }
        catch {
            print(error)
        }
    }
    
    // Login user
    public func loginUser(email: String, password: String) async {
        do {
            let response = try await apiService.loginUser(email: email, password: password)
            print(response)
        }
        catch {
            print(error)
        }
    }
}
