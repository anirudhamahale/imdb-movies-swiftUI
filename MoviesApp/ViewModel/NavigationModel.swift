//
//  NavigationModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 11/09/22.
//

import SwiftUI

class NavigationModel: ObservableObject {
  @Published var selectedIndex: Int = 0
  @Published var popularPath = NBNavigationPath()
  @Published var topRatedPath = NBNavigationPath()
  
  func appendView<V: Hashable>(_ value: V) {
    if selectedIndex == 0 {
      popularPath.append(value)
    } else {
      topRatedPath.append(value)
    }
  }
  
  func goBack() {
    if selectedIndex == 0 {
      popularPath.removeLast()
    } else {
      topRatedPath.removeLast()
    }
  }
  
  func getCurrentPath() -> NBNavigationPath {
    if selectedIndex == 0 {
      return popularPath
    } else {
      return topRatedPath
    }
  }
  
}
