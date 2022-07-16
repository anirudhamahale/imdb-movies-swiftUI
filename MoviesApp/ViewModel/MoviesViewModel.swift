//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Combine
import Foundation

class MoviesViewModel: BaseViewModel {
  
  private let networkManager = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  
  @Published var movies: [MovieModel] = []
  var page = 1
  
  func fetchMovies() {
    networkManager.getPopularMovies(1)
      .receive(on: DispatchQueue.main)
      .sink { error in
        
      } receiveValue: { newMovies in
        if newMovies.count > 0 {
          self.page += 1
        }
        self.movies.append(contentsOf: newMovies)
      }.store(in: &subscriptions)
  }
  
  func refreshMovies() {
    networkManager.getPopularMovies(1)
      .receive(on: DispatchQueue.main)
      .sink { error in
        
      } receiveValue: { newMovies in
        self.movies = newMovies
      }.store(in: &subscriptions)
  }
  
}
