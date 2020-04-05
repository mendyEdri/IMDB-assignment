//
//  KeyValueStorage.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

protocol KeyValueStorage {
    func save(key: String)
    func hasItem(key: String) -> Bool
    func loadItem(from key: String) -> Any?
    func deleteItem(from key: String) -> Bool
}
