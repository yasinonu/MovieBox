//
//  UserViewModel.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

import Foundation

class UserViewModel: ObservableObject {
    let apiService = APIService.shared
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var currentUser: User? = nil
    
    @MainActor
    public func fetchMe() async {
        do {
            let user = try await apiService.fetchMe()
            
            self.currentUser = user
            
            self.name = user.name
            self.surname = user.surname
            self.email = user.email
        }
        catch {
            print("Error fetching user data: \(error)")
        }
    }
    
    public func updateUser() async {
        do {
            let response = try await apiService.updateUserProfile(name: name, surname: surname, email: email, password: password)
            print(response.user)
        }
        catch {
            print("Error updating user profile: \(error)")
        }
    }
    
    private func logout() {
        currentUser = nil
    }
}
