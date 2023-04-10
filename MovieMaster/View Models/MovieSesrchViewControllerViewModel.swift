//
//  MovieSesrchViewControllerViewModel.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import Foundation
import UIKit

class MovieSesrchViewControllerViewModel
{
    var movies:[Movie] = []
    var viewModels:[SearchResultsTableCellViewModel] = []
    private let movieManager = MoviesManager()
    var rootViewController:UIViewController
    
    init(rootVc:UIViewController)
    {
        self.rootViewController = rootVc
    }
    
    
    func generateViewModels()
    {
        for movie in movies {
            let vm = SearchResultsTableCellViewModel(movie: movie)
            viewModels.append(vm)
        }
    }
    func numberOfRows() -> Int
    {
        viewModels.count
    }
    func viewModel(for inidexPath:IndexPath) -> SearchResultsTableCellViewModel
    {
        viewModels[inidexPath.row]
    }
    func searchMovies(for text:String)
    {
        if text != "" {
            movieManager.searchMovies(query: text) { [weak self] result in
                switch result {
                case .success(let movies):
                    self?.movies.append(contentsOf: movies)
                    DispatchQueue.main.async {
                        self?.viewModels = []
                        self?.movies = movies
                        self?.generateViewModels()
                        NotificationCenter.default.post(name: Notification.Name("ResultGenerated"), object: nil)
                    }
                case .failure(let error):
                    print("Failed to fetch movies: \(error.localizedDescription)")
                }
            }

        }
        else if text == ""
        {
            self.viewModels = []
            self.movies = []
            self.generateViewModels()
            NotificationCenter.default.post(name: Notification.Name("ResultGenerated"), object: nil)
        }
    }
    func didSelectRow(at indexPath:IndexPath)
    {
        let movie = movies[indexPath.row]
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        let viewModel = MovieDetailViewControllerViewModel(movie: movie)
        vc.viewModel = viewModel
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
}
