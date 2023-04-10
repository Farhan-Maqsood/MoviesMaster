//
//  HomeMoviesCollectionCellViewModel.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 09/04/2023.
//

import Foundation
import UIKit


class HomeMoviesCollectionCellViewModel{
    
    var movie:Movie
    let sharedContext = CoreDataOperations.shared
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func movieName()->String
    {
        return movie.title
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
    
    func releaseDate() -> String
    {
        return movie.releaseDate ?? ""
    }
    func btnFavTapped() -> UIColor
    {
        if sharedContext.isMovieAlreadySaved(movieId: movie.id)
        {
            sharedContext.removeMovieFromCoreData(movieId: movie.id)
            return .black
        }
        else
        {
            sharedContext.saveMovieToCoreData(movie: self.movie)
            return .systemPink
        }
        
    }
    func btnFavColor () -> UIColor
    {
        if sharedContext.isMovieAlreadySaved(movieId: movie.id)
        {
            return .systemPink
        }
        else
        {
            return .black
        }
        
    }
    
    
}
