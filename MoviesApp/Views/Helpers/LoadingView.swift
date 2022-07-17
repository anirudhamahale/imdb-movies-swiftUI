//
//  LoadingView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import SwiftUI
import Combine

struct LoadingView: View {
  
  @State var isLoading = true
  let title: String
  
  var body: some View {
    VStack(spacing: 16) {
      ActivityIndicator(isAnimating: $isLoading)
      Text(title)
        .multilineTextAlignment(.center)
        .font(.system(size: 24))
    }
  }
}

//struct LoadingView_Previews: PreviewProvider {
//  static var previews: some View {
//    LoadingView()
//  }
//}
