//
//  MovieDetailView.swift
//  MovieBox
//
//  Created by Yasin Onur on 25.05.2025.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(URL(string: movie.posterURL))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                    
                    HStack(spacing: 12) {
                        Text("\(movie.year.description)")
                        Text(movie.category)
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text(movie.rating.formatted(.number.precision(.fractionLength(1))))
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Text(movie.description)
                        .font(.body)
                    
                    if !movie.actors.isEmpty {
                        Text("Cast")
                            .font(.headline)
                        
                        Text(movie.actors.formatted(.list(type: .and)))
                            .font(.subheadline)
                    }
                    Spacer()
                        .frame(height: 100)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MovieDetailView(movie: .mock)
}
