//
//  MovieViewModel.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/10/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit

struct MovieViewModel {
    
    static func createPopularMovieCellViewModel(for movie: Movie ) -> PopularMovieCellViewModel {
        
        let url = "https://image.tmdb.org/t/p/w92\(movie.poster_path ?? movie.backdrop_path ?? "")"
        return PopularMovieCellViewModel( titleText: movie.title,
                                          posterImageUrl: url,
                                          popularityLabelText: movie.popularity.getAttributedString(with: "Popularity"),
                                          voteCountLabelText:  movie.vote_count.getAttributedString(with: "Vote Count"),
                                          voteAverageLabelText: movie.vote_average.getAttributedString(with: "Vote Average"))
    }
    
    static func createTopRatedMovieViewModel(for movie: Movie ) -> TopRatedTableViewCellViewModel {
          
            let url = "https://image.tmdb.org/t/p/w154\(movie.poster_path ?? movie.backdrop_path ?? "")"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = "\(dateFormatter.string(from: movie.releaseDate))"
            return TopRatedTableViewCellViewModel( titleText: movie.title,
                                       posterImageUrl: url,
                                       popularityLabelText: movie.popularity.getAttributedString(with: "Popularity"),
                                       voteCountLabelText:  movie.vote_count.getAttributedString(with: "Vote Count"),
                                       voteAverageLabelText: movie.vote_average.getAttributedString(with: "Vote Average"),
                                       releaseDateLabelText: dateString.getAttributedString(with: "Release Date"))
        }
    
      static func createNowPlayingMovieCellViewModel(for movie: Movie ) -> NowPlayingMovieCellViewModel {
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd"
             let url = "https://image.tmdb.org/t/p/w92\(movie.poster_path ?? movie.backdrop_path ?? "")"
             let releaseDate = "\(dateFormatter.string(from: movie.releaseDate))"
             return NowPlayingMovieCellViewModel( titleText: movie.title,
                                        overviewText: movie.overview,
                                        posterImageUrl: url,
                                        releastDateText: releaseDate.getAttributedString(with: "Release Date"))
         }
    
    
}

extension Float {
    func getAttributedString(with label: String) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let boldFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        let font = UIFont.systemFont(ofSize: 17, weight: .regular)
        let attributeBold = [NSAttributedString.Key.font: boldFont]
        let attributeNormal = [NSAttributedString.Key.font: font]
        let left = NSAttributedString(string: label + " \u{2192} ", attributes: attributeBold)
        result.append(left)
        result.append(NSAttributedString(string: "\(self) ", attributes: attributeNormal))
        return result
    }
}

extension Int {
    func getAttributedString(with label: String) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let boldFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        let font = UIFont.systemFont(ofSize: 17, weight: .regular)
        let attributeBold = [NSAttributedString.Key.font: boldFont]
        let attributeNormal = [NSAttributedString.Key.font: font]
        let left = NSAttributedString(string: label + " \u{2192} ", attributes: attributeBold)
        result.append(left)
        result.append(NSAttributedString(string: "\(self) ", attributes: attributeNormal))
        return result
    }
}

extension String {
    func getAttributedString(with label: String) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let boldFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        let font = UIFont.systemFont(ofSize: 17, weight: .regular)
        let attributeBold = [NSAttributedString.Key.font: boldFont]
        let attributeNormal = [NSAttributedString.Key.font: font]
        let left = NSAttributedString(string: label + " \u{2192} ", attributes: attributeBold)
        result.append(left)
        result.append(NSAttributedString(string: "\(self) ", attributes: attributeNormal))
        return result
    }
}


