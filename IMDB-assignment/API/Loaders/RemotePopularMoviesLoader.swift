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
    public typealias Result = Swift.Result<PopularMoviesList, RemoteLoader.Error>
    
    public var httpClient: HTTPClient
    
    public init(http: HTTPClient) {
        self.httpClient = http
    }
    
    public func load(with url: URL, completion: @escaping (Result) -> Void) {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        httpClient.get(with: request) { result in
            switch result {
            case let .success(data, response):
                completion(PopularMoviesListDataMapper.map(data: data, from: response))
            
            case .failure:
                completion(.failure(.invalidData))
            }
        }
    }
}

struct PopularMoviesListDataMapper {
    private init() {}
    private static var ok200: Int { 200 }
    
    static func map(data: Data, from response: HTTPURLResponse) -> RemotePopularMoviesLoader.Result {
        guard response.statusCode == ok200,
            let movieList = try? JSONDecoder().decode(PopularMoviesList.self, from: data) else {
                return .failure(.invalidData)
        }
        return .success(movieList)
    }
}
