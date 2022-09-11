//
//  NavigationModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 11/09/22.
//

import SwiftUI

class NavigationModel: ObservableObject {
  @Published var popularPath = NBNavigationPath()
  @Published var topRatedPath = NBNavigationPath()
}
