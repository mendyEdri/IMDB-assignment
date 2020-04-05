//
//  GenreViewModel.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

struct GenreViewModel {
    private let data: Genre
    
    var id: Int {
        return data.id
    }
    
    var displayText: String {
        return data.name
    }
    
    init(genre: Genre) {
        self.data = genre
    }
}
