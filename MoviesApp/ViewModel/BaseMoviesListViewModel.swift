//
//  BaseMoviesListViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 26/08/22.
//

import Foundation
import Combine

// Do not create an instance of this class.
class BaseMoviesListViewModel: BaseViewModel, ViewModelType {
  
  enum State {
    case loading
    case movies(MoviesData)
    case error(Error)
    case noData
  }
  
  enum Input {
    // True will indicate refresh
    case fetchMovies(Bool)
  }
  
  struct MoviesData {
    let movies: [MovieModel]
    let moreRemaining: Bool
    let isRefreshing: Bool
  }
  
  @Published
  private(set) var state: State = .loading
  
  private var currentPage = 1
  private var isLoading: Bool = false
  private var movies: [MovieModel] = []
  private var isMoreRemaining = false
  private var isRefreshing = false
  
  func trigger(_ input: Input) {
    switch input {
    case .fetchMovies(let shouldRefresh):
      isRefreshing = shouldRefresh
      fetchMovies()
    }
  }
  
  private func fetchMovies() {
    guard !isLoading else { return }
    if isRefreshing {
      currentPage = 1
      state = .movies(MoviesData(movies: movies, moreRemaining: isMoreRemaining, isRefreshing: isRefreshing))
    }
    isLoading = true
    if movies.count == 0 {
      state = .loading
    }
    getRemoteMovies(page: currentPage)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
        self?.isRefreshing = false
        self?.processCompletion(completion)
      } receiveValue: { [weak self] newMovies in
        self?.processReceivedValue(newMovies)
      }.store(in: &subscriptions)
  }
  
  private func processReceivedValue(_ newMovies: [MovieModel]) {
    isRefreshing = false
    if currentPage == 1 {
      movies = newMovies
    } else {
      movies.append(contentsOf: newMovies)
    }
    if newMovies.count >= 20 && currentPage < 5 {
      currentPage += 1
      isMoreRemaining = true
    } else {
      isMoreRemaining = false
    }
    if movies.count == 0 {
      state = .noData
    } else {
      state = .movies(MoviesData(movies: movies, moreRemaining: isMoreRemaining, isRefreshing: isRefreshing))
    }
    isLoading = false
  }
  
  private func processCompletion(_ completion: Subscribers.Completion<Error>) {
    switch completion {
    case .failure(let error):
      if error._code == NSURLErrorNotConnectedToInternet && movies.count == 0 {
        if movies.count == 0 {
          state = .noData
        }
      } else if movies.count == 0 {
        state = .error(error)
      }
    default: break
    }
  }
  
  func getAllMovies() -> [MovieCD] {
    fatalError()
  }
  
  func saveMovies(_ movies: [MovieModel]) {
    fatalError()
  }
  
  func clearMovies() {
    fatalError()
  }
  
  func getRemoteMovies(page: Int) -> AnyPublisher<[MovieModel], Error> {
    fatalError()
  }
  
}
