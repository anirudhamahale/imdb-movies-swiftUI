//
//  PopularMoviesViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Combine
import Foundation

class PopularMoviesViewModel: BaseMoviesListViewModel {

  private let networkManager = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  private let localDataManager = MovieDataManager()
  
  override func getAllMovies() -> [MovieCD] {
    return localDataManager.getAllPopularMovies()
  }
  
  override func saveMovies(_ movies: [MovieModel]) {
    localDataManager.savePopularMovies(movies)
  }
  
  override func clearMovies() {
    localDataManager.clearPopular()
  }
  
  override func getRemoteMovies(page: Int) -> AnyPublisher<[MovieModel], Error> {
    return networkManager.getPopularMovies(page: page)
  }
  
}
