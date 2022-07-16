//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

struct MovieModel: Codable, Identifiable, Equatable {
  let id: Int
  let originalTitle, releaseDate, posterPath: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case releaseDate = "release_date"
    case posterPath = "poster_path"
  }
  
  static func ==(lhs: MovieModel, rhs: MovieModel) -> Bool {
    return lhs.id == rhs.id
  }
  
}
