//
//  MovieDetailsViewModel.swift
//  IMDB-assignment
//
//  Created by Mendy Edri on 05/04/2020.
//  Copyright © 2020 CWT. All rights reserved.
//

import Foundation
import UIKit
import lit_network

class MovieDetailsViewModel {
    
    var model: Movie
    var loader: RemoteMovieVideosLoader
    
    init(model: Movie, http: HTTPClient) {
        self.model = model
        self.loader = RemoteMovieVideosLoader(http: http)
    }
    
    var imageUrl: URL {
        return Movie.baseImageUrl(with: imageSize).appendingPathComponent(model.posterPath)
    }
    
    var displayTitle: String {
        return model.title
    }
    
    var displayDate: String {
        return model.releaseDate
    }
    
    var displayOverview: String {
        return model.overview
    }
    
    var screenTitle: String {
        return "Movie Details"
    }
    
    var videoKey: String?
    func loadVideos() {
        self.loader.load(from: URLS.env.movieVideos(with: String(model.id))) { [weak self] result in
            switch result {
            case let .success(videos):
                self?.videoKey = videos.first?.key
                
            case .failure: break
            }
        }
    }
    
    func playVideo() {
        guard let key = videoKey else { return }
        UIApplication.shared.open(Movie.videoUrl(with: key), options: [:], completionHandler: nil)
    }
    
    private var imageSize: String {
        return "w500"
    }
}
