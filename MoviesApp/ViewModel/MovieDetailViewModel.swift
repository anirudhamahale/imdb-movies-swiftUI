//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {

  enum State {
    case details(MovieModelDetails)
    case loading
    case error(Error)
  }
  
  init(id: Int) {
    self.id = id
    super.init()
  }
  
  private let networkRepo = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  
  let id: Int
  @Published var state = State.loading
  var movieDetail: MovieModelDetails?
  
  func getDetails() {
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
      } receiveValue: { [weak self] movie in
        self?.movieDetail = movie
        self?.state = .details(movie)
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
