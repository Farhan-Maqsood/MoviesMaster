//
//  Movies.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 09/04/2023.
//

import Foundation


struct MovieAPIResponse: Codable {
    let results: [Movie]
}


struct Movie: Codable {
    let id: Int
    let title: String
    let backdrop_path: String?
    let poster_path: String?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdrop_path = "backdrop_path"
        case poster_path = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    
    var posterURL: String? {
        guard let posterPath = poster_path else { return nil }
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    
    var bannerURL: String? {
        guard let bannerUrlPath = backdrop_path else { return nil }
        return "https://image.tmdb.org/t/p/w500\(bannerUrlPath)"
    }
    var formattedReleaseDate: String {
        let dateFormatter = DateFormatter()
        guard let date = dateFormatter.date(from: releaseDate ?? "") else { return "" }
        return date.localizedStringOfDate
    }
}



extension Date {
    var localizedStringOfDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, dd, yyyy"
        return dateFormatter.string(from: self)
    }
}

