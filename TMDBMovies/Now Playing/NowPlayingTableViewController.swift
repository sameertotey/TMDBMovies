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

//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//
//    lazy var viewModel: NowPlayingViewModel = {
//        return NowPlayingViewModel()
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func initView() {
//        self.navigationItem.title = "Now Playing"
//
//        tableView.estimatedRowHeight = 150
//        tableView.rowHeight = UITableView.automaticDimension
//    }
//
//    override func initVM() {
//        viewModel.showAlertClosure = { [weak self] () in
//            DispatchQueue.main.async {
//                if let message = self?.viewModel.alertMessage {
//                    self?.showAlert( message )
//                }
//            }
//        }
//
//        viewModel.updateLoadingStatus = { [weak self] () in
//            DispatchQueue.main.async {
//                let isLoading = self?.viewModel.isLoading ?? false
//                if isLoading {
//                    self?.activityIndicator.startAnimating()
//                    UIView.animate(withDuration: 0.2, animations: {
//                        self?.tableView.alpha = 0.0
//                    })
//                }
//                else
//                {
//                    self?.activityIndicator.stopAnimating()
//                    UIView.animate(withDuration: 0.2, animations: {
//                        self?.tableView.alpha = 1.0
//                    })
//                }
//            }
//        }
//
//        viewModel.reloadTableViewClosure = { [weak self] () in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
//
//        viewModel.initFetch(endpoint: .nowPlaying)
//    }
//}
//
//extension NowPlayingTableViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingMovieCellIdentifier", for: indexPath) as? NowPlayingTableViewCell else {
//            fatalError("Cell not found in storyboard")
//        }
//        cell.movieCellViewModel = viewModel.getCellViewModel(forIndexPath: indexPath)
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//         return 1
//     }
//
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//         return viewModel.numberOfCells
//     }
//}
//
//extension NowPlayingTableViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as? MovieDetailViewController,
//            let selectedIndex = tableView.indexPathForSelectedRow
//        {
//            vc.movieId = viewModel.getMovie(at: selectedIndex).id
//        }
//    }
//}



