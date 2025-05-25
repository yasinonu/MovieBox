//
//  MoviesView.swift
//  MovieBox
//
//  Created by Yasin Onur on 23.05.2025.
//

import SwiftUI

struct MoviesView: View {
    @EnvironmentObject var moviesViewModel: MoviesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            List(moviesViewModel.movies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRow(movie: movie, isLiked: moviesViewModel.likedMovieIDs.contains(movie.id))
                }
            }
            .navigationTitle("Movies")
            .listStyle(.inset)
            .task {
                await fetch()
            }
            .refreshable {
                await fetch()
            }
        }
    }
    
    private func fetch() async {
        await userViewModel.fetchMe()
        
        if let user = userViewModel.currentUser {
            moviesViewModel.likedMovieIDs = user.likedMovies
        }
        
        await moviesViewModel.fetchMovies()
    }
}

#Preview {
    MoviesView()
}
