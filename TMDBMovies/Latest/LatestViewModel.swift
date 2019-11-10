//
//  LatestViewModel.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/10/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit

class LatestViewModel: ViewModel {
    var isLoading: Bool = false
    var alertMessage: String?
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    
    private var movieDetail: Movie? {
        didSet {
            if let movie = movieDetail {
                receivedLatest?(movie)
            }
        }
    }
    
    var receivedLatest: ((_ movie: Movie)->())?
  
    func initFetch() {
        self.isLoading = true
        APIService.shared.GET(endpoint: .latest, params: nil) {
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
}
