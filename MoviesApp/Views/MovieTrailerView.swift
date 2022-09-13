//
//  MovieTrailerView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import SwiftUI
import Combine

struct MovieTrailerView: View {
  
  @ObservedObject var viewModel: MovieTrailerViewModel
  @EnvironmentObject var navigationModel: NavigationModel
  
  var body: some View {
    ZStack {
      switch viewModel.state {
      case .loading:
        LoadingView(title: "Loading details...")
        
      case .error(let error):
        ErrorView(message: error.localizedDescription, buttonTitle: "Retry") {
          viewModel.getDetails()
        }
        
      case .details(let id):
        YoutubeVideoView(videoID: id) {
          navigationModel.goBack()
          // mode.wrappedValue.dismiss()
        }
      }
    }
  }
}



//struct MovieTrailerView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieTrailerView()
//    }
//}
