//
//  PopularMoviesListViewModel.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 04/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation
import lit_network

protocol PopularMoviesListLoaderProtocol {
    func receivedData(_ movies: RemotePopularMoviesLoader.Result)
}

class PopularMoviesListViewModel {

    private let http: HTTPClient
    private let loader: RemotePopularMoviesLoader
    private var page = 1
    private let maximumPages = 5
    var selectedGenreName: String = ""
    
    var data: [PopularMovieViewModel] = []
    
    var delegate: PopularMoviesListLoaderProtocol?
    
    var screenTitle: String {
        return "Popular Movies"
    }
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.http = httpClient
        self.loader = RemotePopularMoviesLoader(http: http)
    }
    
    func loadNext() {
        guard page < maximumPages+1 else { return }
        loader.load(with: URLS.env.popularMovies(for: page)) { [weak self] result in
            switch result {
            case let .success(movies):
                self?.page += 1
                self?.buildViewModes(from: movies.results)
                self?.delegate?.receivedData(.success(movies))
                
            case .failure:
                self?.delegate?.receivedData(.failure(.invalidData))
            }
        }
    }
    
    @discardableResult
    func buildViewModes(from movieList: [Movie]) -> [PopularMovieViewModel] {
        data.append(contentsOf: movieList.map { [weak self] movie in
            PopularMovieViewModel(data: movie, genre: self?.selectedGenreName ?? "")
        })
        return data
     }
}

extension PopularMoviesListViewModel: Collection {
    func index(after i: Int) -> Int {
        return data.index(after: i)
    }
    
    var startIndex: Int { data.startIndex }
    
    var endIndex: Int { data.endIndex }
    
    subscript(index: Int) -> PopularMovieViewModel {
        return data[index]
    }
}
