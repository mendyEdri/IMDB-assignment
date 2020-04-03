//
//  LoaderProtocol.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation
import lit_network

public enum LoaderError: Swift.Error {
    case invalidData
    case connectivity
    case authFailed
    case serverError
    case badURL
}

public protocol RemoteLoader {
    /** General Remote loaders error */
    typealias Error = LoaderError
    
    /** HTTPClient protocol injected. */
    var httpClient: HTTPClient { get }
}
