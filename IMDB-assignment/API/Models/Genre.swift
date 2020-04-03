//
//  Genre.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

public struct Genre: Codable, Equatable {
    let id: String
    let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
