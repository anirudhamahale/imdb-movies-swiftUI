//
//  BaseNetworkManager.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

class BaseNetworkManager {
  func get(url: URL) -> URLSession.DataTaskPublisher {
    return URLSession.shared.dataTaskPublisher(for: url)
  }
}
