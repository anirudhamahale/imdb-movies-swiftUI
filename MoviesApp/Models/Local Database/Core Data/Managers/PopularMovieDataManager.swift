//
//  PopularMovieDataManager.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import Foundation

class PopularMovieDataManager: MovieDataInterface {
  
  let dbHelper = CoreDataHelper.shared
  typealias ModelType = PopularMovieCD
  
  func saveMovies(_ movies: [MovieModel]) {
    movies.forEach { item in
      let object = PopularMovieCD(context: dbHelper.context)
      object.id = "\(item.id)"
      object.releaseDate = item.releaseDate
      object.title = item.originalTitle
      object.overview = item.description
      object.posterUrl = item.posterPath
      dbHelper.create(object)
    }
  }
  
  func getAllMovies() -> [MovieModel] {
    let result = dbHelper.fetch(ModelType.self)
    switch result {
    case .success(let items):
      return items.compactMap { MovieModel.fromLocalDatabase($0) }
    case .failure(_):
      return []
    }
  }
  
  func getWithId(_ id: String) -> MovieModel? {
    let predicate = NSPredicate(format: "id = %@", id)
    let result = dbHelper.fetchFirst(ModelType.self, predicate: predicate)
    switch result {
    case .success(let item):
      guard let item = item else { return nil }
      return MovieModel.fromLocalDatabase(item)
    case .failure(_):
      return nil
    }
  }
  
  func clearAll() {
    dbHelper.clearData(ModelType.self)
  }
}
