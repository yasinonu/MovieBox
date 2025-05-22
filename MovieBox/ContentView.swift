//
//  ContentView.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
}
