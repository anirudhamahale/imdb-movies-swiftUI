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
  
  var movies: [MovieModel] = [] {
    didSet {
      state = .data(movies)
    }
  }
  @Published var isRefreshing = false
  @Published var isLoading: Bool = false
  @Published var reachedLastPage: Bool = false
  @Published var state: ListState<MovieModel> = .loading
  
  private var currentPage = 1
  
  func fetchMovies() {
    guard !reachedLastPage else { return }
    isLoading = true
    if movies.count == 0 {
      state = .loading
    }
    networkManager.getPopularMovies(page: currentPage)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
      } receiveValue: { [weak self] newMovies in
        if newMovies.count >= 20 {
          self?.currentPage += 1
        } else {
          self?.reachedLastPage = true
        }
        self?.movies.append(contentsOf: newMovies)
        self?.isLoading = false
      }.store(in: &subscriptions)
  }
  
  func refreshMovies() {
    currentPage = 1
    isRefreshing = true
    reachedLastPage = false
    networkManager.getPopularMovies(page: currentPage)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isRefreshing = false
      } receiveValue: { [weak self] newMovies in
        self?.isRefreshing = false
        self?.movies = newMovies
      }.store(in: &subscriptions)
  }
}
