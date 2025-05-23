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
    
    var body: some View {
        if authViewModel.isAuthenticated {
            MoviesView()
                .environmentObject(movieViewModel)
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
