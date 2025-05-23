//
//  MoviesViewModel.swift
//  MovieBox
//
//  Created by Yasin Onur on 23.05.2025.
//

import Foundation

class MoviesViewModel: ObservableObject {
    private let apiService: APIService = .shared
    
    // Movies
    @Published var movies: [Movie] = []
    
    // Fetch Movies
    public func fetchMovies() async {
        do {
            let movies = try await apiService.fetchAllMovies()
            
            self.movies = movies
        }
        catch {
            print("Error fetching movies: \(error)")
        }
    }
}
