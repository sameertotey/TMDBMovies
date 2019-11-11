//
//  NowPlayingTableViewController.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/9/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit
import SDWebImage

class NowPlayingTableViewController: MoviesTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Now Playing"
    }
    
    @objc override func refresh() {
          viewModel.initFetch(endpoint: .nowPlaying)
   }
}

extension NowPlayingTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingMovieCellIdentifier", for: indexPath) as? NowPlayingTableViewCell else {
            fatalError("Cell not found in storyboard")
        }
        let movie = viewModel.getMovie(at: indexPath)
        cell.movieCellViewModel = MovieViewModel.createNowPlayingMovieCellViewModel(for: movie)
        return cell
    }
}
