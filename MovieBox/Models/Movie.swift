//
//  Movie.swift
//  MovieBox
//
//  Created by Yasin Onur on 23.05.2025.
//


struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let year: Int
    let rating: Double
    let actors: [String]
    let category: String
    let posterURL: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id, title, year, rating, actors, category, description
        case posterURL = "poster_url"
    }
    
    static let mock = Movie(
        id: 20,
        title: "Blade Runner 2049",
        year: 2017,
        rating: 8,
        actors: ["Ryan Gosling", "Harrison Ford", "Ana de Armas"],
        category: "Science Fiction",
        posterURL: "https://de.web.img3.acsta.net/pictures/17/08/30/10/16/406748.jpg",
        description: "Young Blade Runner K's discovery of a long-buried secret leads him to track down former blade runner Rick Deckard."
    )
}
