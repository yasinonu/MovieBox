//
//  AuthViewModel.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    private let apiService: APIService = .shared
    
    // Register/Login Properties
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Register/Login State
    @Published var isRegisterView: Bool = false
    
    // Authentication State
    @Published var isAuthenticated: Bool = false
    
    // Current User
    @Published var currentUser: User? = nil
    
    // Alert Toast
    @Published var toast: Toast? = nil
    
    // Fetch Token from Keychain
    public func fetchToken() {
        if let token = apiService.readAccessToken() {
            APIService.accessToken = token
            self.isAuthenticated = true
            print("Token: \(token)")
        }
    }
    
    init() {
        fetchToken()
    }
    
    // Switch UI to Register View / Login View
    public func switchAuthView() {
        isRegisterView.toggle()
    }
    
    // Register user
    @MainActor
    public func registerUser() async {
        do {
            let response = try await apiService.registerUser(name: name, surname: surname, email: email, password: password)
            apiService.save(accessToken: response.token)
            isAuthenticated = true
            resetFields()
            toast = Toast(message: "Registered successfully", type: .success)
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "An unexpected error occurred", type: .error)
        }
    }
    
    // Login user
    @MainActor
    public func loginUser() async {
        do {
            let response = try await apiService.loginUser(email: email, password: password)
            apiService.save(accessToken: response.token)
            isAuthenticated = true
            resetFields()
            toast = Toast(message: "Logged in successfully", type: .success)
        }
        catch let error as AppError? {
            toast = Toast(message: error?.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "An unexpected error occurred", type: .error)
        }
    }
    
    // Logout user
    public func logout() {
        apiService.deleteAccessToken()
        APIService.accessToken = nil
        currentUser = nil
        isAuthenticated = false
        
        toast = Toast(message: "Logged out", type: .message)
    }
    
    private func resetFields() {
        name = ""
        surname = ""
        email = ""
        password = ""
    }
}
