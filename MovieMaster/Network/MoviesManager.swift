//
//  MoviesData.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 09/04/2023.
//

import Foundation
import UIKit


class MoviesManager {
    private let apiKey = "e5ea3092880f4f3c25fbc537e9b37dc1"
    var currentPage = 1
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?page=1&api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MovieAPIResponse.self, from: data)
                print(moviesResponse.results)
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMoreMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        currentPage += 1
        let urlString = "https://api.themoviedb.org/3/movie/popular?page=\(currentPage)&api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MovieAPIResponse.self, from: data)
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }.resume()
    }
    
    func searchMovies(query: String, completion: @escaping  (Result<[Movie], Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=e5ea3092880f4f3c25fbc537e9b37dc1&query=\(query)&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MovieAPIResponse.self, from: data)
                print(moviesResponse.results)
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
