//
//  AuthViewModel.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    private let apiService: APIService = .init()
    
    // Register/Login Properties
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Register/Login State
    @Published var isRegisterView: Bool = false
    
    // Authentication State
    @Published var isAuthenticated: Bool = false
    
    @Published var currentUser: User? = nil
    
    // Fetch Token from Keychain
    init() {
        if let token = apiService.readAccessToken() {
            APIService.accessToken = token
            self.isAuthenticated = true
            print("Token: \(token)")
            
            Task {
                await fetchMe()
            }
        }
    }
    
    // Switch UI to Register View / Login View
    public func switchAuthView() {
        isRegisterView.toggle()
    }
    
    // Register user
    @MainActor
    public func registerUser() {
        Task {
            do {
                let response = try await apiService.registerUser(name: name, surname: surname, email: email, password: password)
                apiService.save(accessToken: response.token)
                isAuthenticated = true
                print(response)
            }
            catch {
                print(error)
            }
        }
    }
    
    // Login user
    @MainActor
    public func loginUser() {
        Task {
            do {
                let response = try await apiService.loginUser(email: email, password: password)
                apiService.save(accessToken: response.token)
                isAuthenticated = true
                print(response)
            }
            catch {
                print(error)
            }
        }
    }
    
    // Logout user
    func logout() {
        apiService.deleteAccessToken()
        APIService.accessToken = nil
        currentUser = nil
        isAuthenticated = false
    }
    
    // Fetch current user
    @MainActor
    public func fetchMe() async {
        do {
            let response = try await apiService.fetchMe()
            print(response)
            await MainActor.run {
                self.currentUser = response
            }
        }
        catch {
            print(error)
            logout()
        }
    }
}
