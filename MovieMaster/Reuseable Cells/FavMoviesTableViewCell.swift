//
//  FavMoviesTableViewCell.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import UIKit

class FavMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var btnFav: UIButton!
    var viewModel:FavMoviesTableCellViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config()
    {
        lblMovieName.text = viewModel?.movieName()
        lblReleaseDate.text = viewModel?.releaseDate()
        if let posterUrl = viewModel?.posterUrl()
        {
            self.posterImageView.sd_setImage(with: posterUrl, placeholderImage: UIImage(named: "NoImage"))
        }
        btnFav.tintColor = .systemPink
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnFavAction(_ sender: Any) {
        viewModel?.btnFavTapped()
    }
}
