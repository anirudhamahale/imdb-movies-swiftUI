//
//  ActivityIndicator.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  
  @Binding var isAnimating: Bool
  
  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let v = UIActivityIndicatorView()
    return v
  }
  
  func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
    if isAnimating {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
  }
}
