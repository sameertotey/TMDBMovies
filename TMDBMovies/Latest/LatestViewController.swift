//
//  LatestViewController.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/10/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit

class LatestViewController: BaseViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: LatestViewModel = {
        return LatestViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                isLoading ?
                    self?.activityIndicator.startAnimating()
                    :
                    self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.receivedLatest = { [weak self] (_ movie: Movie) in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "showLatestMovie", sender: movie)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.initFetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController,
            let movie = sender as? Movie
        {
            vc.movieId = movie.id
        }
    }
    
}
