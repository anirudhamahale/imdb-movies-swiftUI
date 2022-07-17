//
//  MovieDataInterface.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import Foundation

protocol MovieDataInterface {
  func saveMovies(_ movies: [MovieModel])
  func getAllMovies() -> [MovieModel]
  func getWithId(_ id: String) -> MovieModel?
  func clearAll()
}
