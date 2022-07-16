//
//  MovieViewRow.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieViewRow: View {
  
  let movie: MovieModel
  
  var body: some View {
    HStack(alignment: .center, spacing: 16) {
      // ImageView
      WebImage(url: URL(string: APPURL.imageRoute+movie.posterPath))
        .resizable()
        .transition(.fade(duration: 0.5)) // Fade Transition with duration
        .scaledToFit()
        .frame(width: 80, height: 80, alignment: .center)
      
      // StackView containing the title and the release date
      VStack(alignment: .leading, spacing: 16) {
        Text(movie.originalTitle)
        Text(movie.releaseDate)
      }
    }
  }
}
