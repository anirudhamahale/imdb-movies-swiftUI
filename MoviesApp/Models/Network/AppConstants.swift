//
//  AppConstants.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Foundation

struct APPURL {
  
  private enum Environment {
    enum dev {
      static let baseURL = "https://api.themoviedb.org/3"
      static let imageRoute = "https://image.tmdb.org/t/p/w500"
    }
  }
  
  private struct APICalls {
    static let environment = Environment.dev.self
    static let baseURL = environment.baseURL
    static let imageRoute = environment.imageRoute
    
    static let popularMovieList = "/movie/popular"
    static let topRatedMovieList = "/movie/top_rated"
    static let movieDetails = "/movie"
  }
  
  static var popularMovieList: String {
    return APICalls.baseURL + APICalls.popularMovieList
  }
  
  static var topRatedMovieList: String {
    return APICalls.baseURL + APICalls.topRatedMovieList
  }
  
  static var movieDetails: String {
    return APICalls.baseURL + APICalls.movieDetails
  }
  
  static var imageRoute: String {
    return APICalls.imageRoute
  }
  
}

