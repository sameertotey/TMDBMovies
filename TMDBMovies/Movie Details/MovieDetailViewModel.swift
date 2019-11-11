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
                movieDetailsSetClosure?(createMovieDetailFields(for: movie))
            }
        }
    }
    
    var latestMovieId: Int? {
        didSet {
            if let id = latestMovieId {
                initFetchDetail(for: id)
            }
        }
    }
    
    var movieDetailsSetClosure: ((_ fields: MovieDetailFields)->())?
  
    func initFetchDetail(for id: Int) {
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
    
    func fetchLatest() {
           self.isLoading = true
           APIService.shared.GET(endpoint: .latest, params: nil) {
               [weak self] (result: Result<Movie, APIService.APIError>) in
               self?.isLoading = false
               switch result {
               case let .success(response):
                    self?.latestMovieId = response.id
               case let .failure(err):
                   self?.alertMessage = "\(err)"
                   break
               }
           }
       }
    
    private func createMovieDetailFields(for movie: Movie) -> MovieDetailFields {
        let genres = movie.genres?.map {$0.name} ?? [String]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = "\(dateFormatter.string(from: movie.releaseDate))"
        return MovieDetailFields(
            titleText: movie.title,
            overviewText: movie.overview,
            posterImageUrl: "https://image.tmdb.org/t/p/original\(movie.poster_path ?? movie.backdrop_path ?? "")",
            genreText: getGenresDisplayText(label: "Genre", genres: genres),
            popularityLabelText: movie.popularity.getAttributedString(with: "Popularity"),
            voteCountLabelText:  movie.vote_count.getAttributedString(with: "Vote Count"),
            voteAverageLabelText: movie.vote_average.getAttributedString(with: "Vote Average"),
            releaseDateLabelText: dateString.getAttributedString(with: "Release Date")
        )
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

struct MovieDetailFields {
    let titleText: String
    let overviewText: String
    let posterImageUrl: String
    let genreText: NSAttributedString
    let popularityLabelText: NSAttributedString
    let voteCountLabelText: NSAttributedString
    let voteAverageLabelText: NSAttributedString
    let releaseDateLabelText: NSAttributedString
}
