//
//  ViewController.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 05/04/2023.
//

import UIKit

class ViewController: UIViewController {

    private let moviesManager = MoviesManager()
    var movies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviesManager.fetchMovies { [weak self] result in
                    switch result {
                    case .success(let movies):
                        self?.movies = movies
                        DispatchQueue.main.async {
                            self?.navigateToHomeMovieController(movies: self!.movies)
                            
                        }
                    case .failure(let error):
                        print("Failed to fetch movies: \(error.localizedDescription)")
                    }
                }
    }
    
    func navigateToHomeMovieController(movies:[Movie])
    {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeMoviesViewController") as! HomeMoviesViewController
        let viewModel = HomeMoviesViewControllerViewModel(movies: movies,rootVc: viewController)
        viewController.homeMoviesViewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
        
    }


}

