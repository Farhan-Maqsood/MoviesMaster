//
//  HomeMoviesViewController.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 07/04/2023.
//

import UIKit

class HomeMoviesViewController: UIViewController {

    private let moviesManager = MoviesManager()
    var movies: [Movie] = []
    var homeMoviesViewModel: HomeMoviesViewControllerViewModel?
    
    @IBOutlet weak var MoviesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Home"
        MoviesCollectionView.delegate = self
        MoviesCollectionView.dataSource = self
        self.registerCell()
        self.navigationItem.hidesBackButton = true
        let SearchMoviesButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        if let customImage = UIImage(named: "Fav.Heart.Empty") {
            let favMoviesButton = UIBarButtonItem(image: customImage, style: .plain, target: self, action: #selector(favMoviesButtonTappedd))
            navigationItem.rightBarButtonItems = [SearchMoviesButton,favMoviesButton]
        }
        NotificationCenter.default.addObserver(self, selector: #selector(FavMovieRemoved), name: Notification.Name("FavMovieRemoved"), object: nil)

        
    }
    @objc func FavMovieRemoved()
    {
        homeMoviesViewModel?.generateViewModels()
        self.MoviesCollectionView.reloadData()
    }
    
    @objc func searchButtonTapped() {
            homeMoviesViewModel?.searchButtontapped()
        }
        @objc func favMoviesButtonTappedd() {
            homeMoviesViewModel?.favMoviesButtonTapped()
        }
                                              
    func loadMoreMovies()
    {
        moviesManager.fetchMoreMovies { [weak self] result in
                    switch result {
                    case .success(let movies):
                        self?.movies.append(contentsOf: movies)
                        DispatchQueue.main.async {
                            self?.homeMoviesViewModel?.movies.append(contentsOf: movies)
                            self?.homeMoviesViewModel?.generateViewModels()
                            self?.MoviesCollectionView.reloadData()
                        }
                    case .failure(let error):
                        print("Failed to fetch movies: \(error.localizedDescription)")
                    }
                }
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

extension HomeMoviesViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeMoviesViewModel?.numberOfCell() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMoviesCollectionViewCell", for: indexPath) as! HomeMoviesCollectionViewCell
        cell.viewModel = homeMoviesViewModel?.viewModelForCell(for: indexPath)
        cell.config()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (homeMoviesViewModel?.numberOfCell() ?? 0) - 1{
                loadMoreMovies()
            }
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeMoviesViewModel?.didSelectItem(at: indexPath)
    }

    
    
}
extension HomeMoviesViewController {
    
    func registerCell()
    {
        MoviesCollectionView.register(UINib(nibName: "HomeMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeMoviesCollectionViewCell")
    }
}
