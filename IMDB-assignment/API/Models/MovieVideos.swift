//
//  MovieVideos.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

struct MovieVideos: Codable {
    let id, iso639, iso3166, key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639 = "iso_639_1"
        case iso3166 = "iso_3166_1"
        case key, name, site, size, type
    }
}
