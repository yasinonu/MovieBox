//
//  ProfileView.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Personal Info")) {
                    FieldView(label: "Name", text: $userViewModel.name)
                    FieldView(label: "Surname", text: $userViewModel.surname)
                    FieldView(label: "Email", text: $userViewModel.email)
                }
                Section(header: Text("Account")) {
                    HStack {
                        Text("Password")
                        Spacer()
                        SecureField("Enter new password", text: $userViewModel.password)
                            .multilineTextAlignment(.trailing)
                    }
                    Button(role: .destructive, action: {
                        authViewModel.logout()
                        userViewModel.currentUser = nil
                    }) {
                        Text("Log out")
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                Button(action: {
                    Task {
                        await userViewModel.updateUser()
                    }
                }) {
                    Text("Save")
                }
            }
        }
    }
    
    private func FieldView(label: String, text: Binding<String>) -> some View {
        HStack {
            Text(label)
            Spacer()
            TextField("Enter \(label)", text: text)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    ProfileView()
}
