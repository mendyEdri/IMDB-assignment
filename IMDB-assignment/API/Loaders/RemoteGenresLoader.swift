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
        httpClient.get(from: url) { result in
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

struct GenresLoaderDataMapper {
    private init() {}
    private static var OK_200: Int { 200 }
    
    internal static func map(data: Data, from response: HTTPURLResponse) -> RemoteGenresLoader.Result {
        guard response.statusCode == OK_200,
        let genres = try? JSONDecoder().decode([Genre].self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(genres)
    }
}

