//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct MovieDetailView: View {
  
  @ObservedObject var viewModel: MovieDetailViewModel
  
  var body: some View {
    ZStack {
      switch viewModel.state {
      case .loading:
        Text("Loading")
        
      case .failed(let error):
        Text(error.localizedDescription)
        
      case .details(let movie):
        ScrollView {
          VStack(alignment: .center, spacing: 16) {
            // ImageView
            WebImage(url: URL(string: movie.posterPath))
              .resizable()
              .placeholder {
                Rectangle().foregroundColor(.gray)
              }
              .transition(.fade(duration: 0.5)) // Fade Transition with duration
              .scaledToFit()
              .frame(height: 240, alignment: .center)
            
            Text(movie.originalTitle)
              .fontWeight(.bold)
              .font(.system(size: 16))
              .multilineTextAlignment(.center)
            
            Text(movie.description)
              .fontWeight(.regular)
              .font(.system(size: 14))
              .multilineTextAlignment(.center)
            
            Button {
              print("show trailer")
            } label: {
              Text("Watch Trailer")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 20))
                .padding()
                .foregroundColor(.white)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 2)
                )
            }.background(Color.red)
              .cornerRadius(8)
            
            Spacer()
          }
          .padding()
        }
      }
    }
  }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
