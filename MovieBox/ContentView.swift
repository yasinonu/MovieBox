//
//  ContentView.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    
    @StateObject var movieViewModel = MoviesViewModel()
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            TabView {
                Tab {
                    MoviesView()
                } label: {
                    Label("All Movies", systemImage: "film")
                }
                Tab {
                    LikedMoviesView()
                } label: {
                    Label("Liked Movies", systemImage: "heart")
                }
                Tab {
                    ProfileView()
                } label: {
                    Label("Profile", systemImage: "person")
                }
            }
            .environmentObject(movieViewModel)
            .environmentObject(userViewModel)
            .environmentObject(authViewModel)
            .task {
                authViewModel.fetchToken()
                await userViewModel.fetchMe()
            }
        }
        else {
            LoginView()
                .environmentObject(authViewModel)
        }
    }
}

#Preview {
    ContentView()
}
