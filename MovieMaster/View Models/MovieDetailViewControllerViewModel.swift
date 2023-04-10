//
//  MovieDetailViewControllerViewModel.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import Foundation

class MovieDetailViewControllerViewModel {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func movieName() -> String
    {
        return self.movie.title
        
    }
    func movieDescription()->String
    {
        return self.movie.overview ?? ""
    }
    func releaseDate()-> String
    {
        return self.movie.releaseDate ?? ""
    }
    func posterUrl() -> URL
    {
        if let url = movie.posterURL{
            return URL(string: url)!
        }
        else
        {
            return URL(string: "https://image.tmdb.org/t/p/w500")!
        }
    }
    func bannererUrl() -> URL
    {
        if let url = movie.bannerURL{
            return URL(string: url)!
        }
        else
        {
            return URL(string: "https://image.tmdb.org/t/p/w500")!
        }
    }
    
    
}
