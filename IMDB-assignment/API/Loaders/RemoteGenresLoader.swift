//
//  RemoteGenresLoader.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation
import lit_network

public struct RemoteGenresLoader: RemoteLoader {
  
    public typealias Result = Swift.Result<[Genre], RemoteLoader.Error>
    
    public var httpClient: HTTPClient
       
    public init(http: HTTPClient) {
        self.httpClient = http
    }
    
    public func load(with url: URL, completion: @escaping (Result) -> Void) {
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        httpClient.get(with: request) { result in
            switch result {
            case let .success(data, response):
                completion(GenresLoaderDataMapper.map(data: data, from: response))
            
            case .failure:
                #warning("Map the error to get a specific one")
                completion(.failure(.connectivity))
            }
        }
    }
}

public struct GenresList: Codable {
    let genres: [Genre]
}

fileprivate struct GenresLoaderDataMapper {
    private init() {}
    private static var ok200: Int { 200 }
    
    static func map(data: Data, from response: HTTPURLResponse) -> RemoteGenresLoader.Result {
        guard response.statusCode == ok200,
        let genres = try? JSONDecoder().decode(GenresList.self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(genres.genres)
    }
}

