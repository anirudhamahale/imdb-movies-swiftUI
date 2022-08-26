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
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + CATransaction.animationDuration()) {
              fetchDetails()
            }
          }
        
      case .error(let error):
        ErrorView(message: error.localizedDescription, buttonTitle: "Retry") {
          fetchDetails()
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
              GeometryReader { geo in
                Text("Watch Trailer")
                  .font(.system(size: 20))
                  .padding()
                  .foregroundColor(Color.white)
                  .frame(width: geo.size.width)
                  .background(Color.red)
                  .cornerRadius(8)
              }
            }
          }.padding()
          Spacer()
        }
        .navigationBarTitle("Movie Details", displayMode: .inline)
      }
    }
  }
  
  private func fetchDetails() {
    viewModel.trigger(.fetchDetails)
  }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
