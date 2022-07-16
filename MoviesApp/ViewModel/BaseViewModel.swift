//
//  BaseViewModel.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 16/07/22.
//

import Combine

class BaseViewModel: ObservableObject {
  var subscriptions = Set<AnyCancellable>()
}
