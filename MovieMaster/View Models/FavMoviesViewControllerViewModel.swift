//
//  FavMoviesViewControllerViewModel.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import Foundation
import UIKit

class FavMoviesViewControllerViewModel {
    
    var roorViewController:UIViewController
    var favMoviesList:[Movie] = []
    let coredataOperations = CoreDataOperations.shared
    var viewModels:[FavMoviesTableCellViewModel] = []
    
    init(roorViewController: UIViewController) {
        self.roorViewController = roorViewController
        
        generateViewModels()
    }
    
    func fetchFavouriteMoviesList()
    {
        if let movies = coredataOperations.fetchMovies() {
            self.favMoviesList = movies
        }
        
    }
    func numberofRows() -> Int
    {
        return favMoviesList.count
    }
    func generateViewModels()
    {
        fetchFavouriteMoviesList()
        viewModels = []
        for favMovie in favMoviesList {
            let vm = FavMoviesTableCellViewModel(movie: favMovie)
            viewModels.append(vm)
        }
    }
    func didSeletFavMovie(for indexPath:IndexPath)
    {
        let movie = favMoviesList[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        let viewModel = MovieDetailViewControllerViewModel(movie: movie)
        vc.viewModel = viewModel
        roorViewController.navigationController?.pushViewController(vc, animated: true)
    }
    func viewModel(for indexPath:IndexPath) -> FavMoviesTableCellViewModel
    {
        return viewModels[indexPath.row]
    }
    
    
}
