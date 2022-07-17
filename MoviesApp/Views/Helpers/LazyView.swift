//
//  LazyView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import SwiftUI

// https://stackoverflow.com/a/61234030/5744323
// https://www.objc.io/blog/2019/07/02/lazy-loading/
struct LazyView<Content: View>: View {
  let build: () -> Content
  init(_ build: @autoclosure @escaping () -> Content) {
    self.build = build
  }
  var body: Content {
    build()
  }
}
