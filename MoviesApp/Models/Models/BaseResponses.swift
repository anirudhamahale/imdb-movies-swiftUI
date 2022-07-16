//
//  BaseResponses.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

struct ListResponse<T: Codable>: Codable {
  let page: Int
  let data: [T]
  
  enum CodingKeys: String, CodingKey {
    case page
    case data = "results"
  }
}
