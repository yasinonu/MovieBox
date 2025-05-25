//
//  MoviesView.swift
//  MovieBox
//
//  Created by Yasin Onur on 23.05.2025.
//

import SwiftUI

struct MoviesView: View {
    @EnvironmentObject var moviesViewModel: MoviesViewModel
    
    var body: some View {
        NavigationStack {
            List(moviesViewModel.movies) { movie in
                MovieRow(movie: movie, isLiked: moviesViewModel.likedMovieIDs.contains(movie.id))
            }
            .navigationTitle("Movies")
            .listStyle(.inset)
            .task {
                await moviesViewModel.fetchMovies()
                await moviesViewModel.fetchLikedMovieIDs()
            }
        }
    }
}

#Preview {
    MoviesView()
}
