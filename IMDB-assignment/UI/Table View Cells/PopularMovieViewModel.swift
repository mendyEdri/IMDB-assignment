//
//  PopularMovieViewModel.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

struct PopularMovieViewModel {
    
    var data: Movie
    
    let markedWord: String
    
    var shouldBeMarked: Bool {
        return containWord()
    }
    
    init(data: Movie, genre: String) {
        self.data = data
        
        self.markedWord = genre
    }
    
    var displayTitle: String {
        return data.title
    }
    
    var imageUrl: URL {
        return Movie.baseImageUrl(with: imageSize).appendingPathComponent(data.posterPath)
    }
    
    // Helpers
    
    private func containWord() -> Bool {
        return data.overview.contains(markedWord)
    }
    
    #warning("make it dynamic. - probably iPad won't be high res with this size")
    private var imageSize: String {
        return "w185"
    }
}
