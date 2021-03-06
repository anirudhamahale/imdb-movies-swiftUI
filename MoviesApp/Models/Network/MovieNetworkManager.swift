//
//  MovieNetworkManager.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Combine
import Foundation

class MovieNetworkManager: BaseNetworkManager {
  
  let apiKey: String
  
  init(apiKey: String) {
    self.apiKey = apiKey
  }
  
  /// A shared JSON decoder to use in calls.
  private let decoder = JSONDecoder()
  
  func getPopularMovies(page: Int) -> AnyPublisher<[MovieModel], Error> {
    let url = "\(APPURL.popularMovieList)?api_key=\(apiKey)&page=\(page)"
    return get(url: URL(string: url)!)
      .map { $0.0 }
      .decode(type: ListResponse<MovieModel>.self, decoder: decoder)
      .map { $0.data }
      .eraseToAnyPublisher()
  }
  
  func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieModel], Error> {
    let url = "\(APPURL.topRatedMovieList)?api_key=\(apiKey)&page=\(page)"
    return get(url: URL(string: url)!)
      .map { $0.0 }
      .decode(type: ListResponse<MovieModel>.self, decoder: decoder)
      .map { $0.data }
      .eraseToAnyPublisher()
  }
  
  func getDetails(id: Int) -> AnyPublisher<MovieModelDetails, Error> {
    let url = "\(APPURL.movieDetails)/\(id)?api_key=\(apiKey)"
    return get(url: URL(string: url)!)
      .map { $0.0 }
      .decode(type: MovieModelDetails.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
  
  func getTrailerKey(id: Int) -> AnyPublisher<String, Error> {
    let url = "\(APPURL.movieTrailer.replacingOccurrences(of: "$movieId", with: "\(id)"))?api_key=\(apiKey)"
    return get(url: URL(string: url)!)
      .map { $0.0 }
      .decode(type: TrailerResponse<VideoId>.self, decoder: decoder)
      .map { $0.data[0].key }
      .eraseToAnyPublisher()
  }
  
}

struct TrailerResponse<T: Codable>: Codable {
  let data: [T]
  
  enum CodingKeys: String, CodingKey {
    case data = "results"
  }
}
