//
//  GenresListViewModel.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 03/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation
import lit_network

#warning("TODO: setup proxy loader")
struct CacheRemoteDataProxy {
    private let httpClient: HTTPClient
    private let storage: KeyValueStorage
    
    private let loader: RemoteLoader
    
    init(httpClient: HTTPClient = URLSessionHTTPClient(), storage: KeyValueStorage, loader: RemoteLoader) {
        self.httpClient = httpClient
        self.storage = storage
        self.loader = loader
    }
}

class GenresListViewModel {
    
    private let http: HTTPClient
    private let loader: RemoteGenresLoader
    public var data: [GenreViewModel] = []
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.http = httpClient
        self.loader = RemoteGenresLoader(http: http)
    }
    
    func loadGenres(_ completion: @escaping ([Genre]) -> Void) {
        loader.load(with: URLS.env.genres) { [weak self] result in
            switch result {
            case let .success(genres):
                self?.buildViewModes(from: genres)
                completion(genres)
                
            case .failure:
                completion([])
            }
        }
    }
    
    private func buildViewModes(from genres: [Genre]) {
        data = genres.map { genre in
            GenreViewModel(genre: genre)
        }
    }
}

#warning("to generalize this as a single protocol extension")
extension GenresListViewModel: Collection {
    func index(after i: Int) -> Int {
        return data.index(after: i)
    }
    
    var startIndex: Int { data.startIndex }
    
    var endIndex: Int { data.endIndex }
    
    subscript(index: Int) -> GenreViewModel {
        return data[index]
    }
}
