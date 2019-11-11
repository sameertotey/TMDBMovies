//
//  BaseViewModel.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/9/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import Foundation

protocol ViewModel {
    var isLoading: Bool {get set }
    var alertMessage: String? {get set }
    var showAlertClosure: (()->())? {get set }
    var updateLoadingStatus: (()->())? {get set }
}

protocol MoviesViewModel : ViewModel {
    var reloadTableViewClosure: (()->())? {get set }
    var movies: [Movie] {get set}
    var numberOfCells: Int {get}
    mutating func initFetch(endpoint: APIService.Endpoint) -> Void
    func getMovie(at indexPath: IndexPath) -> Movie
}

extension MoviesViewModel {
    func getMovie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}

class BaseMoviesViewModel: MoviesViewModel {
    
    var numberOfCells: Int {
        return movies.count
    }
    
    var reloadTableViewClosure: (() -> ())?
    
    var movies: [Movie] = [Movie]() {
        didSet {
            reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            showAlertClosure?()
        }
    }
    
    var showAlertClosure: (() -> ())?
    
    var updateLoadingStatus: (() -> ())?
    
    func initFetch(endpoint: APIService.Endpoint) {
        self.isLoading = true
        APIService.shared.GET(endpoint: endpoint, params: nil) {
            (result: Result<PaginatedResponse<Movie>, APIService.APIError>) in
            self.isLoading = false
            switch result {
            case let .success(response):
                self.movies = response.results
            case let .failure(err):
                self.alertMessage = "\(err)"
                break
            }
        }
    }
}
