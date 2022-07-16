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
    case failed(Error)
  }
  
  init(id: Int) {
    self.id = id
  }
  
  private let networkRepo = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  
  let id: Int
  @Published var state = State.loading
  
  func getDetails() {
    state = .loading
    networkRepo.getDetails(id: id)
      .receive(on: DispatchQueue.main)
      .sink { error in
        switch error {
        case .failure(let error):
          self.state = .failed(error)
        case .finished:
          print("Finished")
        }
      } receiveValue: { [self] movie in
        state = .details(movie)
      }.store(in: &subscriptions)
  }
  
}
