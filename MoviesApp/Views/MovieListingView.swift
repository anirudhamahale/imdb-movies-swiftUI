//
//  MovieListingView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI
import SwiftUIRefresh

struct MovieListingView<T>: View where T: MoviesViewModelInterface {
  
  @ObservedObject var viewModel: T
  @State var title: String
  
  var body: some View {
    NavigationView {
      ZStack {
        List {
          ForEach(viewModel.movies) { movie in
            MovieViewRow(movie: movie)
              .onAppear {
                if movie == viewModel.movies.last && !viewModel.isLoading {
                  viewModel.fetchMovies()
                }
              }
            if movie == viewModel.movies.last {
              HStack {
                Spacer()
                ActivityIndicator(isAnimating: $viewModel.isLoading)
                Spacer()
              }
            }
          }
        }.pullToRefresh(isShowing: $viewModel.isRefreshing) {
          viewModel.refreshMovies()
        }
      }
      .navigationBarTitle("\(title)", displayMode: .inline)
    }.onAppear {
      viewModel.fetchMovies()
    }
  }
}
