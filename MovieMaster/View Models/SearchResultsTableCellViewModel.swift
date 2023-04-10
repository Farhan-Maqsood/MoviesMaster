//
//  SearchResultsTableCellViewModel.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import Foundation

class SearchResultsTableCellViewModel
{
    var movie:Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func movieName() -> String
    {
        return self.movie.title
        
    }
    
    func moviePosterUrl() -> URL
    {
        if let url = movie.posterURL{
            return URL(string: url)!
        }
        else
        {
            return URL(string: "https://image.tmdb.org/t/p/w500")!
        }
    }
    func releaseDate()-> String
    {
        return self.movie.releaseDate ?? ""
    }
}
