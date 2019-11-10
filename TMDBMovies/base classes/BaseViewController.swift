//
//  BaseViewController.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/9/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit
import SDWebImage

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
    }
    
    func initView() {
    }
    
    func initVM() {
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

class MoviesTableViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let refreshControl = UIRefreshControl()
    
    lazy var viewModel = {
        BaseMoviesViewModel()
    }()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action:  #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
   
    override func initView() {
        self.navigationItem.title = "Now Playing"
        
        tableView.estimatedRowHeight = 260
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func initVM() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                }
                else
                {
                    self?.activityIndicator.stopAnimating()
                    self?.refreshControl.endRefreshing()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        refresh()
    }
    
    @objc func refresh() {
    }
}

extension MoviesTableViewController: UITableViewDelegate, UITableViewDataSource {
    // Each subclass needs to override this method to return its own TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingMovieCellIdentifier", for: indexPath) as? NowPlayingTableViewCell else {
            fatalError("Cell not found in storyboard")
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.numberOfCells
     }
}

extension MoviesTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController,
            let selectedIndex = tableView.indexPathForSelectedRow
        {
            vc.movieId = viewModel.getMovie(at: selectedIndex).id
        }
    }
}
