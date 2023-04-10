//
//  CoreDataOperations.swift
//  MovieMaster
//
//  Created by Abdul Rehman on 10/04/2023.
//

import Foundation
import CoreData

class CoreDataOperations {
    
    static let shared = CoreDataOperations()
    private init() {}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MovieMaster")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Operations
    
    func saveMovieToCoreData(movie: Movie) {
        let context = persistentContainer.viewContext
        if isMovieAlreadySaved(movieId: movie.id)
        {
            removeMovieFromCoreData(movieId: movie.id)
        }
        else
        {
            let entity = NSEntityDescription.entity(forEntityName: "FavMovies", in: context)!
            let movieObj = NSManagedObject(entity: entity, insertInto: context)
            movieObj.setValue(movie.id, forKey: "id")
            movieObj.setValue(movie.title, forKey: "movieName")
            movieObj.setValue(movie.posterURL, forKey: "moviePosterUrl")
            movieObj.setValue(movie.bannerURL, forKey: "movieBannerUrl")
            movieObj.setValue(movie.overview, forKey: "movieDescription")
            movieObj.setValue(movie.releaseDate, forKey: "releaseDate")
            saveContext()
        }
    }
    
    func fetchMovies() -> [Movie]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavMovies> = FavMovies.fetchRequest()
        do {
            let moviesObj = try context.fetch(fetchRequest)
            var movies: [Movie] = []
            for movieObj in moviesObj {
                let movie = Movie(id: Int(movieObj.id), title: movieObj.movieName ?? "", backdrop_path: movieObj.movieBannerUrl, poster_path: movieObj.moviePosterUrl, overview: movieObj.movieDescription, releaseDate: movieObj.releaseDate)
                movies.append(movie)
            }
            return movies
        } catch {
            print("Error fetching movies: \(error.localizedDescription)")
            return nil
        }
    }
    func isMovieAlreadySaved(movieId: Int) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavMovies> = FavMovies.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", movieId as NSNumber)

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error fetching movies: \(error.localizedDescription)")
            return false
        }
    }
    func removeMovieFromCoreData(movieId: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavMovies> = FavMovies.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
        do {
            let movies = try context.fetch(fetchRequest)
            if let movie = movies.first {
                context.delete(movie)
                try context.save()
            }
        } catch let error as NSError {
            print("Could not fetch movie. \(error), \(error.userInfo)")
        }
    }
}

