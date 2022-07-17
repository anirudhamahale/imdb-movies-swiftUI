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
    self.getDetails()
  }
  
  private let networkRepo = MovieNetworkManager(apiKey: Constants.imdbAPIKey)
  
  let id: Int
  @Published var state = State.loading
  
  func getDetails() {
    state = .loading
    networkRepo.getDetails(id: id)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        switch completion {
        case .failure(let error):
          self?.state = .error(error)
        case .finished: break
        }
      } receiveValue: { [weak self] movie in
        self?.state = .details(movie)
      }.store(in: &subscriptions)
  }
  
}
