//
//  MovieLikeResponse.swift
//  MovieBox
//
//  Created by Yasin Onur on 23.05.2025.
//

import Foundation

struct MovieLikeResponse: Decodable {
    let message: String
    let likedMovies: [Movie.ID]
}
