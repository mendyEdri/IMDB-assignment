//
//  RemotePopularMoviesLoader.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation
import lit_network

struct RemotePopularMoviesLoader: RemoteLoader {
    var httpClient: HTTPClient
    
    init(http: HTTPClient) {
        self.httpClient = http
    }
}
