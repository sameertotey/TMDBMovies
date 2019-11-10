//
//  NowPlayingTableViewCell.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/9/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit
import SDWebImage

class NowPlayingTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var movieCellViewModel : NowPlayingMovieCellViewModel? {
        didSet {
            titleLabel.text = movieCellViewModel?.titleText
            overviewLabel.text = movieCellViewModel?.overviewText
            if #available(iOS 13.0, *) {
                posterImageView?.sd_setImage(with: URL( string: movieCellViewModel?.posterImageUrl ?? "" ), placeholderImage: UIImage(systemName: " icloud.and.arrow.down.fill"))
            }
            else
            {
                posterImageView?.sd_setImage(with: URL( string: movieCellViewModel?.posterImageUrl ?? "" ))
            }
            releaseDateLabel.text = movieCellViewModel?.releastDateText
        }
    }
}

struct NowPlayingMovieCellViewModel {
    let titleText: String
    let overviewText: String
    let posterImageUrl: String
    let releastDateText: String
    
   
}
