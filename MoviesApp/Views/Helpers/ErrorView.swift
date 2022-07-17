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
      if let buttonTitle = buttonTitle {
        Button {
          action()
        } label: {
          Text(buttonTitle)
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
