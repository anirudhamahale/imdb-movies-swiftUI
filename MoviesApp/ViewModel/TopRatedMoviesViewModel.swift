//
//  TopRatedMoviesViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Combine
import Foundation

class TopRatedMoviesViewModel: BaseMoviesListViewModel {
  
  private let networkManager = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  private let localDataManager = MovieDataManager()
  
  override func getAllMovies() -> [MovieCD] {
    return localDataManager.getAllTopRatedMovies()
  }
  
  override func saveMovies(_ movies: [MovieModel]) {
    localDataManager.saveTopRatedMovies(movies)
  }
  
  override func clearMovies() {
    localDataManager.clearTopRated()
  }
  
  override func getRemoteMovies(page: Int) -> AnyPublisher<[MovieModel], Error> {
    return networkManager.getTopRatedMovies(page: page)
  }
}

