//
//  MovieViewRow.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieViewRow: View {
  var body: some View {
    HStack {
      WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg"))
        .resizable()
        .frame(width: 80, height: 80)
        .scaledToFill()
      VStack {
        Text("Movie Name")
        Text("Release Date")
      }
    }
  }
}
