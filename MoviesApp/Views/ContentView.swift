//
//  ContentView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI
import Combine

struct ContentView: View {
  
  @State var selectedIndex: Int = 0
  private let popularMoviesViewModel = PopularMoviesViewModelV2()
  private let topRatedViewModel = TopRatedMoviesViewModel()
  
  var body: some View {
    TabView(selection: $selectedIndex) {
      MovieListingViewV2(viewModel: popularMoviesViewModel, title: "Popular Movies")
        .tabItem {
          Image(selectedIndex == 0 ? "ic_heart_filled" : "ic_heart")
        }.tag(0)
      MovieListingView(viewModel: topRatedViewModel, title: "Top Rated Movies")
        .tabItem {
          Image(selectedIndex == 1 ? "ic_star_filled" : "ic_star")
        }.tag(1)
    }
  }
}
