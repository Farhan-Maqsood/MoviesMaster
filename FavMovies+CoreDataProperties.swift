//
//  FavMovies+CoreDataProperties.swift
//  
//
//  Created by Farhan Maqsood on 10/04/2023.
//
//

import Foundation
import CoreData


extension FavMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavMovies> {
        return NSFetchRequest<FavMovies>(entityName: "FavMovies")
    }

    @NSManaged public var id: Int64
    @NSManaged public var movieName: String?
    @NSManaged public var moviePosterUrl: String?
    @NSManaged public var movieBannerUrl: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var releaseDate: String?

}
