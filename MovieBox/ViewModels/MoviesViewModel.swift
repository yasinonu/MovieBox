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
    
    var likedMovies: [Movie] {
        return movies.filter { likedMovieIDs.contains($0.id) }
    }
    
    @Published var likedMovieIDs: [Movie.ID] = []
    
    // Fetch Movies
    @MainActor
    public func fetchMovies() async {
        do {
            let movies = try await apiService.fetchAllMovies()
            
            self.movies = movies
        }
        catch {
            print("Error fetching movies: \(error)")
        }
    }
    
    // Like Movie
    @MainActor
    public func likeMovie(id: Movie.ID) async {
        do {
            let response = try await apiService.likeMovie(id: id)
            self.likedMovieIDs = response.likedMovies
            
            print("Liked movies: \(likedMovies)")
        }
        catch {
            print("Error liking movie: \(error)")
        }
    }
    
    // Unlike Movie
    @MainActor
    public func unlikeMovie(id: Movie.ID) async {
        do {
            let response = try await apiService.unlikeMovie(id: id)
            self.likedMovieIDs = response.likedMovies
            
            print("Liked movies: \(likedMovies)")
        }
        catch {
            print("Error unliking movie: \(error)")
        }
    }
    
    // Fetch Liked Movie IDs
    @MainActor
    public func fetchLikedMovieIDs() async {
        do {
            let response = try await apiService.fetchLikedMovieIDs()
            self.likedMovieIDs = response
            
            print("Fetched liked movie IDs: \(likedMovieIDs)")
        }
        catch {
            print("Error fetching liked movie IDs: \(error)")
        }
    }
    
    // Fetch Liked Movies
    @MainActor
    public func fetchLikedMovies() async {
        do {
            let response = try await apiService.fetchLikedMovies()
            // self.likedMovies = response
            
            print("Fetched liked movies: \(likedMovies)")
        }
        catch {
            print("Error fetching liked movies: \(error)")
        }
    }
}
