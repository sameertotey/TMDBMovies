//
//  MovieDetailViewController.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/9/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: BaseViewController {
    
    var movieId: Int? {
        didSet {
            if let id = movieId {
                viewModel.initFetch(for: id)
            }
        }
    }
    
    lazy var viewModel: MovieDetailViewModel = {
        return MovieDetailViewModel()
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        
        viewModel.movieDetailsSetClosure = { [weak self] (_ titleText: String, _ overviewText: String, _ posterImageUrl: String, _ genres: NSAttributedString) in
            DispatchQueue.main.async {
                self?.titleLabel.text = titleText
                self?.overviewLabel.text = overviewText
                self?.genreLabel.attributedText = genres
                if #available(iOS 13.0, *) {
                    self?.posterImage.sd_setImage(with: URL(string: posterImageUrl), placeholderImage: UIImage(systemName: "icloud.and.arrow.down.fill"))
                } else
                {
                    self?.posterImage.sd_setImage(with: URL(string: posterImageUrl))
                }
            }
        }
    }
    
}
