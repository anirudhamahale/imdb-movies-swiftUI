//
//  PopularMoviesView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI

struct PopularMoviesView: View {
  
  @ObservedObject var viewModel = MoviesViewModel()
  
  var body: some View {
    ZStack {
      List {
        ForEach(viewModel.movies) { movie in
          MovieViewRow(movie: movie)
        }
      }
    }.onAppear {
      viewModel.fetchMovies()
    }
  }
}
