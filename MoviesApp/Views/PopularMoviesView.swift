//
//  PopularMoviesView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI
import SwiftUIRefresh

struct PopularMoviesView: View {
  
  @ObservedObject var viewModel = MoviesViewModel()
  
  var body: some View {
    ZStack {
      List {
        ForEach(viewModel.movies) { movie in
          MovieViewRow(movie: movie)
            .onAppear {
              if movie == viewModel.movies.last {
                viewModel.fetchMovies()
              }
            }
        }
      }.pullToRefresh(isShowing: $viewModel.isRefreshing) {
        viewModel.refreshMovies()
      }
    }.onAppear {
      viewModel.fetchMovies()
    }
  }
}
