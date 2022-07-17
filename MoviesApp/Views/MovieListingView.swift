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
        switch viewModel.state {
        case .loading:
          LoadingView(title: "Loading Movies...")
        case .error(let error):
          Text(error.localizedDescription)
          ErrorView(message: error.localizedDescription, buttonTitle: "Retry") {
            viewModel.fetchMovies()
          }
        case .noData:
          Text("No data")
        case .data(let movies):
          List {
            ForEach(movies) { movie in
              NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(id: movie.id))) {
                MovieViewRow(movie: movie)
                  .onAppear {
                    if movie == movies.last && !viewModel.isLoading {
                      viewModel.fetchMovies()
                    }
                  }
              }
              if movie == movies.last {
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
      }
      .navigationViewStyle(.stack)
      .navigationBarTitle("\(title)", displayMode: .inline)
      .alert(isPresented: $viewModel.reachedLastPage) {
        Alert(title: Text("You have reached to the end of the list."))
      }
    }
  }
}
