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
        LoadingView(title: "Loading details...")
        
      case .error(let error):
        ErrorView(message: error.localizedDescription, buttonTitle: "Retry") {
          viewModel.getDetails()
        }
        
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
            
            NavigationLink(destination: MovieTrailerView(viewModel: MovieTrailerViewModel(id: movie.id))) {
              ZStack {
                Color.red
                Text("Watch Trailer")
                  .font(.system(size: 20))
                  .foregroundColor(Color.white)
                  .padding()
                  .overlay(
                    RoundedRectangle(cornerRadius: 8)
                      .stroke(Color.black, lineWidth: 0)
                )
              }
            }
          }.padding()
          Spacer()
        }
        .navigationBarTitle("Movie Details", displayMode: .inline)
      }
    }.onAppear {
      if viewModel.movieDetail == nil {
        viewModel.getDetails()
      }
    }
  }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
