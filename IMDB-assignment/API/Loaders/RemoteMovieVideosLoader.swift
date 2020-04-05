//
//  RemoteMovieVideosLoader.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation
import lit_network

struct RemoteMovieVideosLoader: RemoteLoader {
    typealias Result = Swift.Result<[MovieVideos], RemoteLoader.Error>
    
    var httpClient: HTTPClient
    
    init(http: HTTPClient) {
        self.httpClient = http
    }
    
    func load(from URL: URL, completion: @escaping (Result) -> Void) {
        let request = URLRequest(url: URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        httpClient.get(with: request) { result in
            switch result {
            case let .success(data, response):
                completion(RemoteMovieVideosDataMapper.map(data: data, from: response))
            case .failure:
                completion(.failure(.serverError))
            }
        }
    }
}

fileprivate struct RemoteMovieVideosDataMapper {
    private init() {}
    private static var ok200: Int { 200 }
    
    static func map(data: Data, from response: HTTPURLResponse) -> RemoteMovieVideosLoader.Result {
        guard response.statusCode == ok200,
        let videoList = try? JSONDecoder().decode(MovieVideosList.self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(videoList.results)
    }
}
