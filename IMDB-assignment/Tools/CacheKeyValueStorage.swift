//
//  CacheKeyValueStorage.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

struct CacheKeyValueStorage: KeyValueStorage {
    func save(key: String) {
        
    }
    
    func hasItem(key: String) -> Bool {
        return false
    }
    
    func loadItem(from key: String) -> Any? {
        return nil
    }
    
    func deleteItem(from key: String) -> Bool {
        return false
    }
}
