//
//  ErrorView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import SwiftUI

struct ErrorView: View {
  
  let message: String
  let buttonTitle: String?
  
  let action: () -> Void
  
  var body: some View {
    VStack(spacing: 16) {
      Text(message)
        .multilineTextAlignment(.center)
        .font(.system(size: 20))
      if let buttonTitle = buttonTitle {
        Button {
          action()
        } label: {
          Text(buttonTitle)
            .fontWeight(.bold)
            .font(.system(size: 24))
        }

      }
    }
  }
}

//struct ErrorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorView()
//    }
//}
