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
  
  var body: some View {
    TabView(selection: $selectedIndex) {
      PopularMovies()
        .tabItem {
          VStack {
            Image(selectedIndex == 0 ? "ic_heart_filled" : "ic_heart")
            Text("Popular Movies")
              .foregroundColor(Color.black)
          }
        }.tag(0)
      TopRatedMovies()
        .tabItem {
          VStack {
            Image(selectedIndex == 1 ? "ic_star_filled" : "ic_star")
            Text("Popular Movies")
              .foregroundColor(Color.black)
          }
        }.tag(1)
    }
  }
}
