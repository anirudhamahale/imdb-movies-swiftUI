//
//  MovieListingView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 26/08/22.
//

import SwiftUI
import Combine
import SwiftUIRefresh

struct MovieListingView<T>: View where T: BaseMoviesListViewModel {
  
  @ObservedObject var viewModel: T
  @State var title: String
  @State var reachedLastPage: Bool = false
  
  var body: some View {
    NavigationView {
      ZStack {
        switch viewModel.state {
        case .loading:
          LoadingView(title: "Loading Movies...")
            .onAppear {
              fetchMovies()
            }
        case .error(let error):
          ErrorView(message: error.localizedDescription, buttonTitle: "Retry") {
            fetchMovies()
          }
        case .noData:
          Text("No data")
            .multilineTextAlignment(.center)
            .font(.system(size: 20))
        case .movies(let data):
          List {
            ForEach(data.movies) { movie in
              NavigationLink(destination: LazyView(MovieDetailView(viewModel: MovieDetailViewModel(id: movie.id)))) {
                MovieViewRow(movie: movie)
                  .onAppear {
                    if movie == data.movies.last && data.moreRemaining {
                      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        fetchMovies()
                      }
                    }
                  }
              }
              if movie == data.movies.last && data.moreRemaining {
                HStack {
                  Spacer()
                  ActivityIndicator(isAnimating: .constant(data.moreRemaining))
                  Spacer()
                }
              }
            }
          }.pullToRefresh(isShowing: .constant(data.isRefreshing)) {
            print("Refresheeeee")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              refreshMovies()
            }
          }
        }
      }
      .onReceive(Just(viewModel.state), perform: { state in
        switch state {
        case .movies(let data):
          reachedLastPage = !data.moreRemaining
        default:
          break
        }
      })
      .navigationViewStyle(.stack)
      .navigationBarTitle("\(title)", displayMode: .inline)
      .alert(isPresented: $reachedLastPage) {
        Alert(title: Text("You have reached to the end of the list."))
      }
    }
  }
  
  private func fetchMovies() {
    viewModel.trigger(.fetchMovies(false))
  }
  
  private func refreshMovies() {
    viewModel.trigger(.fetchMovies(true))
  }
}

