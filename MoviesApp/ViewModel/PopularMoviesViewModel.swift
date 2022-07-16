//
//  PopularMoviesViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Combine
import Foundation

class PopularMoviesViewModel: BaseViewModel, MoviesViewModelInterface {
  
  private let networkManager = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  
  @Published var movies: [MovieModel] = []
  @Published var isRefreshing = false
  
  private var page = 1
  
  func fetchMovies() {
    networkManager.getPopularMovies(page)
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
    page = 1
    isRefreshing = true
    networkManager.getPopularMovies(page)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] error in
        self?.isRefreshing = false
      } receiveValue: { [weak self] newMovies in
        print(newMovies)
        self?.isRefreshing = false
        self?.movies = newMovies
      }.store(in: &subscriptions)
  }
  
}
