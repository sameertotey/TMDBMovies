//
//  TopRatedTableViewCell.swift
//  TMDBMovies
//
//  Created by Sameer Totey on 11/10/19.
//  Copyright © 2019 Sameer Totey. All rights reserved.
//

import UIKit
import SDWebImage

class TopRatedTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    var movieCellViewModel : TopRatedTableViewCellViewModel? {
        didSet {
            titleLabel.text = movieCellViewModel?.titleText
            if #available(iOS 13.0, *) {
                posterImageView?.sd_setImage(with: URL( string: movieCellViewModel?.posterImageUrl ?? "" ), placeholderImage: UIImage(systemName: " icloud.and.arrow.down.fill"))
            }
            else
            {
                posterImageView?.sd_setImage(with: URL( string: movieCellViewModel?.posterImageUrl ?? "" ))
            }
            popularityLabel.attributedText = movieCellViewModel?.popularityLabelText
            voteCountLabel.attributedText = movieCellViewModel?.voteCountLabelText
            voteAverageLabel.attributedText = movieCellViewModel?.voteAverageLabelText
        }
    }
}

struct TopRatedTableViewCellViewModel {
    let titleText: String
    let posterImageUrl: String
    let popularityLabelText: NSAttributedString
    let voteCountLabelText: NSAttributedString
    let voteAverageLabelText: NSAttributedString
}
