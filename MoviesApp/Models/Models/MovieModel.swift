//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

struct MovieModel: Codable, Identifiable, Equatable {
  let id: Int
  let originalTitle, releaseDate: String
  var posterPath: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case releaseDate = "release_date"
    case posterPath = "poster_path"
  }
  
  static func ==(lhs: MovieModel, rhs: MovieModel) -> Bool {
    return lhs.id == rhs.id
  }
  
  mutating func updateModel() {
    posterPath = APPURL.imageRoute + posterPath
  }
  
}

struct MovieModelDetails: Codable, Identifiable, Equatable {
  let id: Int
  let originalTitle, releaseDate: String
  var posterPath: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case releaseDate = "release_date"
    case posterPath = "poster_path"
  }
  
  static func ==(lhs: MovieModelDetails, rhs: MovieModelDetails) -> Bool {
    return lhs.id == rhs.id
  }
  
}
