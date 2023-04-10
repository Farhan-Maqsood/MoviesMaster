//
//  FavMoviesTableCellViewModel.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import Foundation

class FavMoviesTableCellViewModel {
    
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
    func isFavourite()->Bool
    {
        return true
    }
    func btnFavTapped()
    {
        if sharedContext.isMovieAlreadySaved(movieId: movie.id)
        {
            sharedContext.removeMovieFromCoreData(movieId: movie.id)
            NotificationCenter.default.post(name: Notification.Name("FavMovieRemoved"), object: nil)
        }
        else
        {
            sharedContext.saveMovieToCoreData(movie: self.movie)
        }
    }
    
}
