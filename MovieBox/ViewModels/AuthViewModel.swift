//
//  AuthViewModel.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    private let apiService: APIService = .init()
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Switch UI to Register View / Login View
    @Published var isRegisterView: Bool = false
    
    @MainActor
    public func switchAuthView() {
        isRegisterView.toggle()
    }
    
    // Register user
    public func registerUser() {
        Task {
            do {
                let response = try await apiService.registerUser(name: name, surname: surname, email: email, password: password)
                apiService.save(accessToken: response.token)
                print(response)
            }
            catch {
                print(error)
            }
        }
    }
    
    // Login user
    public func loginUser() {
        Task {
            do {
                let response = try await apiService.loginUser(email: email, password: password)
                apiService.save(accessToken: response.token)
                print(response)
            }
            catch {
                print(error)
            }
        }
    }
    
    // Fetch me
    public func fetchMe() async {
        do {
            let response = try await apiService.fetchMe()
            print(response)
        }
        catch {
            print(error)
        }
    }
}
