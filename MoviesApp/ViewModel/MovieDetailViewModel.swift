//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

class MovieDetailViewModel: BaseViewModel, ViewModelType {

  enum State {
    case details(MovieModelDetails)
    case loading
    case error(Error)
  }
  
  enum Input {
    case fetchDetails
  }
  
  @Published
  private(set) var state: State = .loading
  
  init(id: Int) {
    self.id = id
    super.init()
  }
  
  private let networkRepo = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  
  let id: Int
  private var movieDetail: MovieModelDetails?
  private var isLoading = false
  
  func trigger(_ input: Input) {
    switch input {
    case .fetchDetails:
      getDetails()
    }
  }
  
  private func getDetails() {
    guard !isLoading else { return }
    isLoading = true
    state = .loading
    networkRepo.getDetails(id: id)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        switch completion {
        case .failure(let error):
          if error._code == NSURLErrorNotConnectedToInternet {
            self?.fetchMovieFromLocalDB()
          } else {
            self?.state = .error(error)
          }
        case .finished: break
        }
        self?.isLoading = false
      } receiveValue: { [weak self] movie in
        self?.movieDetail = movie
        self?.state = .details(movie)
        self?.isLoading = false
      }.store(in: &subscriptions)
  }
  
  private func fetchMovieFromLocalDB() {
    if let dbMovie = MovieDataManager().getWithId("\(id)"), let movie = MovieModelDetails.fromLocalDatabase(dbMovie) {
      movieDetail = movie
      state = .details(movieDetail!)
    } else {
      state = .error(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey : "Something went wrong!"]))
    }
  }
}
