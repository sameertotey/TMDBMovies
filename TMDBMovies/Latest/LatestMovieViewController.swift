//
//  LatestMovieViewController.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/10/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit

class LatestMovieViewController: MovieDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Latest TMDB Movie"
    }
    
    override func initVM() {
        super.initVM()
        viewModel.fetchLatest()
      }
}
