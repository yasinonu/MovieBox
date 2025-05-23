//
//  User.swift
//  MovieBox
//
//  Created by Yasin Onur on 22.05.2025.
//


struct User: Decodable {
    let id: String
    let name: String
    let surname: String
    let email: String
    
    let likedMovies: [Movie.ID]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case surname
        case email
        case likedMovies
        case createdAt
        case updatedAt
    }
}
