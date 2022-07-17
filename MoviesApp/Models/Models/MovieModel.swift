//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation
import CoreData

struct MovieModel: Codable, Identifiable, Equatable {
  let id: Int
  let originalTitle, description: String
  var posterPath, releaseDate: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case releaseDate = "release_date"
    case posterPath = "poster_path"
    case description = "overview"
  }
  
  init(id: Int, originalTitle: String, description: String, posterPath: String, releaseDate: String) {
    self.id = id
    self.originalTitle = originalTitle
    self.description = description
    self.posterPath = posterPath
    self.releaseDate = releaseDate
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    originalTitle = try container.decode(String.self, forKey: .originalTitle)
    description = try container.decode(String.self, forKey: .description)
    let postPathTemp = try container.decode(String.self, forKey: .posterPath)
    posterPath = APPURL.imageRoute + postPathTemp
    releaseDate = try container.decode(String.self, forKey: .releaseDate).changeDate(from: "yyyy-MM-dd", to: "MMM d, yyyy")
  }
  
  static func ==(lhs: MovieModel, rhs: MovieModel) -> Bool {
    return lhs.id == rhs.id
  }
  
  static func fromLocalDatabase(_ item: NSManagedObject) -> MovieModel? {
    switch item {
    case let item as PopularMovieCD:
      return MovieModel(id: Int(item.id!)!,
                        originalTitle: item.title!,
                        description: item.overview ?? "",
                        posterPath: item.posterUrl ?? "",
                        releaseDate: item.releaseDate ?? "")
    case let item as TopRatedMovieCD:
      return MovieModel(id: Int(item.id!)!,
                        originalTitle: item.title!,
                        description: item.overview ?? "",
                        posterPath: item.posterUrl ?? "",
                        releaseDate: item.releaseDate ?? "")
    default:
      return nil
    }
  }
}

struct MovieModelDetails: Codable, Identifiable, Equatable {
  let id: Int
  let originalTitle, description: String
  var posterPath: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case posterPath = "poster_path"
    case description = "overview"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    originalTitle = try container.decode(String.self, forKey: .originalTitle)
    description = try container.decode(String.self, forKey: .description)
    let postPathTemp = try container.decode(String.self, forKey: .posterPath)
    posterPath = APPURL.imageRoute + postPathTemp
  }
  
  static func ==(lhs: MovieModelDetails, rhs: MovieModelDetails) -> Bool {
    return lhs.id == rhs.id
  }
  
}

struct VideoId: Codable {
  let key: String
  
  enum CodingKeys: String, CodingKey {
    case key
  }
}
