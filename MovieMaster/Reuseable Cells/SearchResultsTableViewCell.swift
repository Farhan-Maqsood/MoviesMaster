//
//  SearchResultsTableViewCell.swift
//  MovieMaster
//
//  Created by Abdul Rehman on 10/04/2023.
//

import UIKit
import SDWebImage

class SearchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblResultMovieName: UILabel!
    @IBOutlet weak var lblResultMovieReleaseDate: UILabel!
    @IBOutlet weak var searchResultImageView: UIImageView!
    var viewModel:SearchResultsTableCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config()
    {
        lblResultMovieName.text = viewModel?.movieName()
        lblResultMovieReleaseDate.text = viewModel?.releaseDate()
        if let posterUrl = viewModel?.moviePosterUrl()
        {
            self.searchResultImageView.sd_setImage(with: posterUrl, placeholderImage: UIImage(named: "NoImage"))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
