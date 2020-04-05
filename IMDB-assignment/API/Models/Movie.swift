//
//  Movie.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

// MARK: - Result
struct Movie: Codable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String
    let originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

extension Movie {
    static func baseImageUrl(with size: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/")!.appendingPathComponent(size)
    }
    
    static func videoUrl(with id: String) -> URL {
        return URL(string: "https://www.youtube.com/watch?v=\(id)")!
    }
}
