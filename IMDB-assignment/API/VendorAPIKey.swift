//
//  VendorAPIKey.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 02/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

/** API Key for movie-vendor requests. Could be in use for more vendors later on */
public protocol VendorAPIKey {
    var name: String { get }
    var value: String { get }
}

public struct IMDBAPIKey: VendorAPIKey {
    
    public init() {}
    
    public var name: String {
      return "api_key"
    }
    
    public var value: String {
        return "b8dfd91394ee6633cb7772de6a117a41"
    }
}
