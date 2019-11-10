//
//  MovieDetailViewModel.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/9/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit

class MovieDetailViewModel: ViewModel {
    var isLoading: Bool = false
    var alertMessage: String?
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    private var movieDetail: Movie? {
        didSet {
            if let movie = movieDetail {
                setupMovieDisplayFields(movie)
            }
        }
    }
    
    var movieDetailsSetClosure: ((_ titleText: String, _ overviewText: String, _ porterImageUrl: String, _ genres: NSAttributedString)->())?
  
    func initFetch(for id: Int) {
        self.isLoading = true
        APIService.shared.GET(endpoint: .movieDetail(movie: id), params: nil) {
            [weak self] (result: Result<Movie, APIService.APIError>) in
            self?.isLoading = false
            switch result {
            case let .success(response):
                self?.movieDetail = response
            case let .failure(err):
                self?.alertMessage = "\(err)"
                break
            }
        }
    }
    
    private func setupMovieDisplayFields(_ movie: Movie) {
        let titleText = movie.title
        let overviewText = movie.overview
        let posterImageUrl = "https://image.tmdb.org/t/p/original\(movie.poster_path ?? movie.backdrop_path ?? "")"
        let genres = movie.genres?.map {$0.name} ?? [String]()
        let genreText = getGenresDisplayText(label: "Genre", genres: genres)
        movieDetailsSetClosure?(titleText, overviewText, posterImageUrl, genreText)
    }

    private func getGenresDisplayText(label: String, genres: [String]) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let boldFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        let font = UIFont.systemFont(ofSize: 17, weight: .regular)
        let attributeBold = [NSAttributedString.Key.font: boldFont]
        let attributeNormal = [NSAttributedString.Key.font: font]
        let left = NSAttributedString(string: label + " \u{2192} \n", attributes: attributeBold)
        result.append(left)
        for genre in genres {
            result.append(NSAttributedString(string: "\(genre) \n", attributes: attributeNormal))
        }
        return result
    }
}
