//
//  TopRatedViewController.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/10/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit
import SDWebImage

class TopRatedViewController: MoviesTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationItem.title = "Top Rated"
    }

    @objc override func refresh() {
       viewModel.initFetch(endpoint: .topRated)
   }
}

extension TopRatedViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as? TopRatedTableViewCell else {
            fatalError("Cell not found in storyboard")
        }
        let movie = viewModel.getMovie(at: indexPath)
        cell.movieCellViewModel = MovieViewModel.createTopRatedMovieViewModel(for: movie)
        return cell
    }
}


