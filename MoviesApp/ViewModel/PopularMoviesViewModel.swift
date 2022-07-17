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
  private let localDataManager = MovieDataManager()
  
  var movies: [MovieModel] = [] {
    didSet {
      state = .data(movies)
    }
  }
  @Published var isRefreshing = false
  @Published var isLoading: Bool = false
  @Published var reachedLastPage: Bool = false
  @Published var state: ListState<MovieModel> = .loading
  
  var currentPage = 1
  
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
        self?.processCompletion(completion)
      } receiveValue: { [weak self] newMovies in
        self?.processReceivedValue(newMovies)
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
        self?.processCompletion(completion)
      } receiveValue: { [weak self] newMovies in
        self?.movies = []
        self?.processReceivedValue(newMovies)
        self?.isRefreshing = false
      }.store(in: &subscriptions)
  }
  
  private func processReceivedValue(_ newMovies: [MovieModel]) {
    if newMovies.count > 0 && currentPage == 1 {
      localDataManager.clearPopular()
    }
    localDataManager.savePopularMovies(newMovies)
    if currentPage == 1 {
      movies = newMovies
    } else {
      movies.append(contentsOf: newMovies)
    }
    if newMovies.count >= 20 {
      currentPage += 1
    } else {
      reachedLastPage = true
    }
    if movies.count == 0 {
      state = .noData
    }
    isLoading = false
  }
  
  private func processCompletion(_ completion: Subscribers.Completion<Error>) {
    switch completion {
    case .failure(let error):
      if error._code == NSURLErrorNotConnectedToInternet && movies.count == 0 {
        movies = localDataManager.getAllPopularMovies()
          .compactMap { MovieModel.fromLocalDatabase($0) }
        if movies.count == 0 {
          state = .noData
        }
      } else if movies.count == 0 {
        state = .error(error)
      }
    default: break
    }
  }
}
