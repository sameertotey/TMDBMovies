//
//  PopularViewController.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/10/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit
import SDWebImage

class PopularViewController: MoviesTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.title = "Popular"
    }
    
    @objc override func refresh() {
        viewModel.initFetch(endpoint: .popular)
    }
}

extension PopularViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell", for: indexPath) as? PopularTableViewCell else {
            fatalError("Cell not found in storyboard")
        }
        let movie = viewModel.getMovie(at: indexPath)
        cell.movieCellViewModel = MovieViewModel.createPopularMovieCellViewModel(for: movie)
        return cell
    }
}


