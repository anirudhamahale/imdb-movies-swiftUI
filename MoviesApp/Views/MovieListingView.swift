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
            NavigationLink {
              let detailViewModel = MovieDetailViewModel(id: movie.id)
              MovieDetailView(viewModel: detailViewModel)
            } label: {
              MovieViewRow(movie: movie)
                .onAppear {
                  if movie == viewModel.movies.last && !viewModel.isLoading {
                    viewModel.fetchMovies()
                  }
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
      .alert(isPresented: $viewModel.reachedLastPage) {
        Alert(title: Text("You have reached to the end of the list."))
      }
    }.onAppear {
      viewModel.fetchMovies()
    }
  }
}
