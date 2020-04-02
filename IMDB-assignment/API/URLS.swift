//
//  URLS.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 02/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation

public enum URLS {
    case production
    case stage
    
    public static var env: URLS {
        switch Configuration.env {
        case .production:
            return .production
        case .stage:
            return .stage
        }
    }
    
    /** Vendor key for some of the requests. currently used as movie vendor api key */
    static private let prodKey: VendorAPIKey = IMDBAPIKey()
    
    /** For use if we would have a different account (and different api key) for stage env */
    static private let stageKey: VendorAPIKey = IMDBAPIKey()
    
    /** Constant of URLQueryItem used for apiKey for both production/stage */
    static var apiKeyItem: URLQueryItem {
        switch URLS.env {
        case .production:
            return URLQueryItem(name: prodKey.name, value: prodKey.value)
        case .stage:
            return URLQueryItem(name: stageKey.name, value: stageKey.value)
        }
    }
}

public extension URLS {
    // MARK: List of product URLS
    
    /** URL of movie genres list */
    var genres: URL {
        switch self {
        case .production:
            return URL(string:"https://api.themoviedb.org/3/genre/movie/list?")!.withItems(URLS.apiKeyItem)!
        case .stage:
            return URL(string: "https://api.themoviedb.org/3/genre/movie/list?")!.withItems(URLS.apiKeyItem)!
        }
    }
    
    /** URL popular movies. takes pagination number as a parameter */
    func popularMovies(for page: Int) -> URL {
        guard let url = popularMovieUrlBuilder(at: page) else {
            fatalError("Movie URL is broken, probably a developer mistake")
        }
        
        return url
    }
    
    /** URL a videos of a movie, takes id as a parameter */
    func movieVideos(with id: String) -> URL {
        return self.movieDetailsBase.appendingPathComponent(id).appendingPathComponent("videos").withItems(URLS.apiKeyItem)!
    }
}

extension URLS {
    // MARK: Helpers
    
    /** build the popular movie url with query items needed */
    private func popularMovieUrlBuilder(at page: Int) -> URL? {
        let url = moviesBase
        let page = URLQueryItem(name: "page", value: String(page))
        let language = URLQueryItem(name: "language", value: "en-US")
        
        return url.withItems(URLS.apiKeyItem, language, page)
    }
    
    private var moviesBase: URL {
        switch self {
        case .production:
            return URL(string: "https://api.themoviedb.org/3/movie/popular?")!
        case .stage:
            return URL(string: "https://api.themoviedb.org/3/movie/popular?")!
        }
    }
    
    private var movieDetailsBase: URL {
        switch self {
        case .production:
            return URL(string:"https://api.themoviedb.org/3/movie/")!
        case .stage:
            return URL(string:"https://api.themoviedb.org/3/movie/")!
        }
    }
}
