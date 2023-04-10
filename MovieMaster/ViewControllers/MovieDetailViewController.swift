//
//  MovieDetailViewController.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var movieDetailView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var lblmovieName: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    var viewModel: MovieDetailViewControllerViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movie Detail"
        btnFav.tintColor = .black
        config()
        // Do any additional setup after loading the view.
    }
    
    func config()
    {
        lblmovieName.text = viewModel?.movieName()
        lblReleaseDate.text = viewModel?.releaseDate()
        if let posterUrl = viewModel?.posterUrl()
        {
            self.posterImageView.sd_setImage(with: posterUrl, placeholderImage: UIImage(named: "NoImage"))
        }
        if let posterUrl = viewModel?.bannererUrl()
        {
            self.bannerImageView.sd_setImage(with: posterUrl, placeholderImage: UIImage(named: "NoImage"))
        }
        descriptionTextView.text = viewModel?.movieDescription()
        movieDetailView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        movieDetailView.isOpaque = false
        
    }
    
    @IBAction func btnFavAction(_ sender: Any) {
        btnFav.tintColor = .systemPink
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
