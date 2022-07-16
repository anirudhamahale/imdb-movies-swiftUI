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
  
  func fetchMovies()
  func refreshMovies()
}
