//
//  LoginView.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("MovieBox'a hoşgeldin")
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            VStack(alignment: .trailing) {
                if authViewModel.isRegisterView {
                    TextField("İsim", text: $authViewModel.name)
                        .textFieldStyle(.roundedBorder)
                    TextField("Soyisim", text: $authViewModel.surname)
                        .textFieldStyle(.roundedBorder)
                }
                TextField("Email", text: $authViewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                SecureField("Parola", text: $authViewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                Button(action: {
                    Task {
                        if authViewModel.isRegisterView {
                            await authViewModel.registerUser()
                        }
                        else {
                            await authViewModel.loginUser()
                        }
                    }
                }) {
                    Text(authViewModel.isRegisterView ? "Kayıt Ol": "Giriş Yap")
                        .fontWeight(.semibold)
                        .frame(width: 80)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            VStack {
                Text(authViewModel.isRegisterView ? "Zaten bir hesabın var mı?" : "Henüz bir hesabın yok mu?")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Button(action: { withAnimation { authViewModel.switchAuthView() } }) {
                    Text(authViewModel.isRegisterView ? "Giriş Yap" : "Kayıt Ol")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
            }
            Spacer()
        }
        .padding()
        .onChange(of: authViewModel.name) { oldValue, newValue in
            if newValue.count > 48 {
                authViewModel.name = String(newValue.prefix(48))
            }
        }
        .onChange(of: authViewModel.surname) { oldValue, newValue in
            if newValue.count > 48 {
                authViewModel.surname = String(newValue.prefix(48))
            }
        }
        .onChange(of: authViewModel.email) { oldValue, newValue in
            if newValue.count > 48 {
                authViewModel.email = String(newValue.prefix(64))
            }
        }
    }
}

#Preview {
    LoginView()
}
