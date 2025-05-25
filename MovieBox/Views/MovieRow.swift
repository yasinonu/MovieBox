//
//  MovieRow.swift
//  MovieBox
//
//  Created by Yasin Onur on 23.05.2025.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    let isLiked: Bool
    @EnvironmentObject var moviesViewModel: MoviesViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.posterURL)!) { phase in
                phase.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 75)
            }
            .clipShape(.rect(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text(movie.title)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text(movie.year.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack(alignment: .bottom) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(movie.rating.formatted(.number.precision(.fractionLength(1))))
                    Spacer()
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .onTapGesture {
                            Task {
                                if !isLiked {
                                    await moviesViewModel.likeMovie(id: movie.id)
                                }
                                else {
                                    await moviesViewModel.unlikeMovie(id: movie.id)
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    List {
        MovieRow(movie: .mock, isLiked: false)
        MovieRow(movie: .mock, isLiked: false)
        MovieRow(movie: .mock, isLiked: false)
        MovieRow(movie: .mock, isLiked: false)
        MovieRow(movie: .mock, isLiked: false)
    }
    .listStyle(.inset)
}
