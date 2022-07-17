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
      WebImage(url: URL(string: movie.posterPath))
        .resizable()
        .placeholder {
          Rectangle().foregroundColor(.gray)
        }
        .transition(.fade(duration: 0.5)) // Fade Transition with duration
        .scaledToFit()
        .frame(width: 80, height: 80, alignment: .center)
      
      // StackView containing the title and the release date
      VStack(alignment: .leading, spacing: 16) {
        Text(movie.originalTitle)
          .font(.system(size: 16))
          .foregroundColor(Color.black)
        Text(movie.releaseDate)
          .font(.system(size: 12))
          .foregroundColor(Color.black.opacity(0.7))
      }
    }
  }
}

extension String {
  func changeDate(from: String, to: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = DateFormatter.Style.long
    dateFormatter.dateFormat = from
    guard let convertedDate = dateFormatter.date(from: self) else { return "" }
    dateFormatter.dateFormat = to
    let date = dateFormatter.string(from: convertedDate)
    return date
  }
}
