//
//  HomeMoviesCollectionViewCell.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 07/04/2023.
//

import UIKit
import SDWebImage


class HomeMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviewImageView: UIImageView!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblMoviewReleaseDate: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    var viewModel: HomeMoviesCollectionCellViewModel?
    private let moviesManager = MoviesManager()
    var posterUrl:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config()
    {
        lblMovieName.text = viewModel?.movieName()
        lblMoviewReleaseDate.text = viewModel?.releaseDate()
        btnFavourite.tintColor = viewModel?.btnFavColor()
        if let posterUrl = viewModel?.posterUrl()
        {
            self.moviewImageView.sd_setImage(with: posterUrl, placeholderImage: UIImage(named: "NoImage"))
        }
    }

    @IBAction func btnFavouriteAction(_ sender: Any) {
        btnFavourite.tintColor = viewModel?.btnFavTapped()
    }
}

extension HomeMoviesCollectionViewCell
{
    func loadPosterImage(posterUrl:URL)
    {
       downloadImage(from: posterUrl) { image in
                DispatchQueue.main.async {
//                    self.moviewImageView.image = image
            }
        }
    }
    
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        self.moviewImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "NoImage"))
    }
}
