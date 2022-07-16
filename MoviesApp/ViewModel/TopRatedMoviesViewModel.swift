//
//  TopRatedMoviesViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Combine
import Foundation

class TopRatedMoviesViewModel: BaseViewModel, MoviesViewModelInterface {
  
  private let networkManager = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  
  @Published var movies: [MovieModel] = []
  @Published var isRefreshing = false
  @Published var isLoading: Bool = false
  @Published var reachedLastPage: Bool = false
  
  private var currentPage = 1
  
  func fetchMovies() {
    guard !reachedLastPage else { return }
    isLoading = true
    networkManager.getTopRatedMovies(page: currentPage)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] error in
        self?.isLoading = false
      } receiveValue: { [weak self] newMovies in
        if newMovies.count > 0 {
          self?.currentPage += 1
        }
        self?.movies.append(contentsOf: newMovies)
        self?.isLoading = false
      }.store(in: &subscriptions)
  }
  
  func refreshMovies() {
    currentPage = 1
    isRefreshing = true
    networkManager.getTopRatedMovies(page: currentPage)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] error in
        self?.isRefreshing = false
      } receiveValue: { [weak self] newMovies in
        self?.isRefreshing = false
        self?.movies = newMovies
      }.store(in: &subscriptions)
  }
}

