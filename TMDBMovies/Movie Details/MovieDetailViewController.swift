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
                viewModel.initFetchDetail(for: id)
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
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
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
        
        viewModel.movieDetailsSetClosure = { [weak self] (_ fields: MovieDetailFields) in
            DispatchQueue.main.async {
                self?.titleLabel.text = fields.titleText
                self?.overviewLabel.text = fields.overviewText
                self?.genreLabel.attributedText = fields.genreText
                if #available(iOS 13.0, *) {
                    self?.posterImage.sd_setImage(with: URL(string: fields.posterImageUrl), placeholderImage: UIImage(systemName: "icloud.and.arrow.down.fill"))
                } else
                {
                    self?.posterImage.sd_setImage(with: URL(string: fields.posterImageUrl))
                }
                self?.releaseDateLabel.attributedText = fields.releaseDateLabelText
                self?.popularityLabel.attributedText = fields.popularityLabelText
                self?.voteCountLabel.attributedText = fields.voteCountLabelText
                self?.voteAverageLabel.attributedText = fields.voteAverageLabelText
            }
        }
    }
    
}
