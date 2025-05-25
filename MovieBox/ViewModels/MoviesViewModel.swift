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
    
    // Alert Toast
    @Published var toast: Toast? = nil
    
    // Fetch Movies
    @MainActor
    public func fetchMovies() async {
        do {
            let movies = try await apiService.fetchAllMovies()
            
            self.movies = movies
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "Failed to fetch movies", type: .error)
        }
    }
    
    // Like Movie
    @MainActor
    public func likeMovie(id: Movie.ID) async {
        do {
            let response = try await apiService.likeMovie(id: id)
            self.likedMovieIDs = response.likedMovies
            
            print("Liked movies: \(likedMovies)")
            
            toast = Toast(message: "Successfully liked movie", type: .success)
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "Failed to like movie", type: .error)
        }
    }
    
    // Unlike Movie
    @MainActor
    public func unlikeMovie(id: Movie.ID) async {
        do {
            let response = try await apiService.unlikeMovie(id: id)
            self.likedMovieIDs = response.likedMovies
            
            toast = Toast(message: "Successfully unliked movie", type: .success)
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "Failed to unlike movie", type: .error)
        }
    }
    
    // Fetch Liked Movie IDs
    @MainActor
    public func fetchLikedMovieIDs() async {
        do {
            let response = try await apiService.fetchLikedMovieIDs()
            self.likedMovieIDs = response
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "Failed to fetch liked movie", type: .error)
        }
    }
    
    // Fetch Liked Movies
    @MainActor
    public func fetchLikedMovies() async {
        do {
            let _ = try await apiService.fetchLikedMovies()
            // self.likedMovies = response
        }
        catch let error as AppError {
            toast = Toast(message: error.errorDescription ?? "An error occurred", type: .error)
        }
        catch {
            toast = Toast(message: "Failed to fetch liked movies", type: .error)
        }
    }
}
