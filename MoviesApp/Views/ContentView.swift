//
//  ContentView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI
import Combine

struct ContentView: View {
  
  private let popularMoviesViewModel = PopularMoviesViewModel()
  private let topRatedViewModel = TopRatedMoviesViewModel()
  @StateObject var navigationModel = NavigationModel()
  
  var body: some View {
    TabView(selection: $navigationModel.selectedIndex) {
      NBNavigationStack(path: $navigationModel.popularPath) {
        MovieListingView(viewModel: popularMoviesViewModel, title: "Popular Movies")
      }.tabItem {
        Image(navigationModel.selectedIndex == 0 ? "ic_heart_filled" : "ic_heart")
      }.tag(0)
      
      NBNavigationStack(path: $navigationModel.topRatedPath) {
        MovieListingView(viewModel: topRatedViewModel, title: "Top Rated Movies")
      }.tabItem {
        Image(navigationModel.selectedIndex == 1 ? "ic_star_filled" : "ic_star")
      }.tag(1)
      
    }.environmentObject(navigationModel)
  }
}
