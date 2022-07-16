//
//  PopularMoviesView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI

struct PopularMoviesView: View {
  var body: some View {
    List {
      MovieViewRow()
      MovieViewRow()
      MovieViewRow()
    }
  }
}
