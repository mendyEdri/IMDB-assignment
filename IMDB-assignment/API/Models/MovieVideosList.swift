//
//  MovieVideosList.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

struct MovieVideosList: Codable {
    let id: Int
    let results: [MovieVideos]
}
