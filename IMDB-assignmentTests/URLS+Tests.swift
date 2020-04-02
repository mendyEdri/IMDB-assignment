//
//  URLS+Tests.swift
//  IMDB-assignmentTests
//
//  Created by Mendy Edri on 02/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import XCTest
import IMDB_assignment

class URLS_Tests: XCTestCase {

    override func setUp() {
        Configuration.env = .production
    }
    
    private let apiKey = IMDBAPIKey()
    
    func test_genresURL() {
        let expected = URL(string:"https://api.themoviedb.org/3/genre/movie/list?\(apiKey.name)=\(apiKey.value)")
        
        XCTAssertEqual(URLS.env.genres, expected)
    }
    
    func test_popularMoviesURL() {
        let page = 8
        let expected = URL(string: "https://api.themoviedb.org/3/movie/popular?\(apiKey.name)=\(apiKey.value)&language=en-US&page=\(page)")
        
        XCTAssertEqual(URLS.env.popularMovies(for: page), expected)
    }
    
    func test_movieVideos() {
        let movieId = "joker2020"
        
        let expected = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?\(apiKey.name)=\(apiKey.value)")
        
        XCTAssertEqual(URLS.env.movieVideos(with: movieId), expected)
    }

}
