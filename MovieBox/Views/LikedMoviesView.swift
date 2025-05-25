//
//  LikedMoviesView.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

import SwiftUI

struct LikedMoviesView: View {
    @EnvironmentObject var moviesViewModel: MoviesViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            List(moviesViewModel.likedMovies) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRow(movie: movie, isLiked: moviesViewModel.likedMovieIDs.contains(movie.id))
                }
            }
            .navigationTitle("Liked Movies")
            .listStyle(.inset)
            .task {
                await moviesViewModel.fetchLikedMovies()
            }
        }
    }
}

#Preview {
    LikedMoviesView()
}
