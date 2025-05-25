//
//  UserViewModel.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

import Foundation

class UserViewModel: ObservableObject {
    let apiService = APIService.shared
    
    // User Info Properties
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Current User
    @Published var currentUser: User? = nil
    
    // Alert Toast
    @Published var toast: Toast? = nil
    
    // Fetch Current User Data
    @MainActor
    public func fetchMe() async {
        do {
            let user = try await apiService.fetchMe()
            
            self.currentUser = user
            
            self.name = user.name
            self.surname = user.surname
            self.email = user.email
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "Failed to fetch user", type: .error)
        }
    }
    
    // Update User Info
    @MainActor
    public func updateUser() async {
        do {
            let response = try await apiService.updateUserProfile(name: name, surname: surname, email: email, password: password)
            toast = Toast(message: "Successfully updated profile", type: .success)
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "Failed to update user", type: .error)
        }
    }
    
    // Logout
    private func logout() {
        currentUser = nil
    }
}
