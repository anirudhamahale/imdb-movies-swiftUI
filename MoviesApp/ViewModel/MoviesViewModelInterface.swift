//
//  MoviesViewModelInterface.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

protocol MoviesViewModelInterface: ObservableObject {
  
  var movies: [MovieModel] { get set }
  var isRefreshing: Bool { get set }
  var isLoading: Bool { get set }
  var reachedLastPage: Bool { get set }
  var state: ListState<MovieModel> { get set }
  var currentPage: Int { get set }
  
  func fetchMovies()
  func refreshMovies()
  
}

enum ListState<T> {
  case loading
  case error(Error)
  case noData
  case data([T])
}
