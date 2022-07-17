//
//  MovieDataManager.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import Foundation

class MovieDataManager {
  
  let dbHelper = CoreDataHelper.shared
  typealias ModelType = MovieCD
  
  func savePopularMovies(_ movies: [MovieModel]) {
    let allMovies = getAllRawMovies()
    movies.forEach { item in
      // If movie is found with id than just update the flag to true else add new movie
      if let matchedMovie = allMovies.first(where: { $0.id! == "\(item.id)" }) {
        matchedMovie.isPopular = true
        dbHelper.update(matchedMovie)
      } else {
        let object = MovieCD(context: dbHelper.context)
        object.id = "\(item.id)"
        object.releaseDate = item.releaseDate
        object.title = item.originalTitle
        object.overview = item.description
        object.posterUrl = item.posterPath
        object.isPopular = true
        dbHelper.create(object)
      }
    }
  }
  
  func saveTopRatedMovies(_ movies: [MovieModel]) {
    let allMovies = getAllRawMovies()
    movies.forEach { item in
      // If movie is found with id than just update the flag to true else add new movie
      if let matchedMovie = allMovies.first(where: { $0.id! == "\(item.id)" }) {
        matchedMovie.isTopRated = true
        dbHelper.update(matchedMovie)
      } else {
        let object = MovieCD(context: dbHelper.context)
        object.id = "\(item.id)"
        object.releaseDate = item.releaseDate
        object.title = item.originalTitle
        object.overview = item.description
        object.posterUrl = item.posterPath
        object.isTopRated = true
        dbHelper.create(object)
      }
    }
  }
  
  func getAllRawMovies() -> [MovieCD] {
    let result = dbHelper.fetch(MovieCD.self)
    switch result {
    case .success(let items):
      return items
    case .failure(_):
      return []
    }
  }
  
  func getAllPopularMovies() -> [MovieCD] {
    let result = dbHelper.fetch(MovieCD.self, predicate: NSPredicate(format: "isPopular = %d", true))
    switch result {
    case .success(let items):
      return items
    case .failure(_):
      return []
    }
  }
  
  func getAllTopRatedMovies() -> [MovieCD] {
    let result = dbHelper.fetch(MovieCD.self, predicate: NSPredicate(format: "isTopRated = %d", true))
    switch result {
    case .success(let items):
      return items
    case .failure(_):
      return []
    }
  }
  
  func getWithId(_ id: String) -> MovieCD? {
    let predicate = NSPredicate(format: "id = %@", id)
    let result = dbHelper.fetchFirst(MovieCD.self, predicate: predicate)
    switch result {
    case .success(let item):
      return item
    case .failure(_):
      return nil
    }
  }
  
  func clearPopular() {
    // Marking the movies isPopular property to false
    getAllPopularMovies()
      .forEach { movie in
        movie.isPopular = false
        dbHelper.update(movie)
      }
    // Clearing the movies with isPopular & isTopRated both to false
    dbHelper.clearData(MovieCD.self, predicate: NSPredicate(format: "isPopular = %d && isTopRated = %d", false, false))
  }
  
  func clearTopRated() {
    // Marking the movies isTopRated property to false
    getAllTopRatedMovies()
      .forEach { movie in
        movie.isPopular = false
        dbHelper.update(movie)
      }
    // Clearing the movies with isPopular & isTopRated both to false
    dbHelper.clearData(MovieCD.self, predicate: NSPredicate(format: "isTopRated = %d && isPopular == %d", false, false))
  }
}

