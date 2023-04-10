//
//  HomeMoviesViewControllerViewModel.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 07/04/2023.
//

import Foundation
import UIKit

class HomeMoviesViewControllerViewModel {
    
    var movies:[Movie]
    var rootViewController: UIViewController
    var viewModels:[HomeMoviesCollectionCellViewModel] = []
    
    init(movies: [Movie], rootVc:UIViewController) {
        self.movies = movies
        self.rootViewController = rootVc
        generateViewModels()
    }
    
    func generateViewModels()
    {
        for movie in movies {
            let vm =  HomeMoviesCollectionCellViewModel(movie: movie)
            viewModels.append(vm)
        }
    }
    func numberOfCell() -> Int {
        return movies.count
    }
    
    func viewModelForCell(for indexPath: IndexPath) -> HomeMoviesCollectionCellViewModel
    {
        return viewModels[indexPath.row]
    }
    func didSelectItem(at indexPath:IndexPath)
    {
        let movie = movies[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        let viewModel = MovieDetailViewControllerViewModel(movie: movie)
        vc.viewModel = viewModel
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchButtontapped()
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieSesrchViewController") as! MovieSesrchViewController
        let viewModel = MovieSesrchViewControllerViewModel(rootVc: self.rootViewController)
        vc.moviesearchViewModel = viewModel
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func favMoviesButtonTapped()
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FavMoviesViewController") as! FavMoviesViewController
        let viewModel = FavMoviesViewControllerViewModel(roorViewController: self.rootViewController)
        vc.viewModdel = viewModel
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
