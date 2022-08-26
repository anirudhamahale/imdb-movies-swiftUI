//
//  ViewModelType.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 26/08/22.
//

import Combine
import Foundation

protocol ViewModelType: ObservableObject where ObjectWillChangePublisher.Output == Void {
  associatedtype State
  associatedtype Input
  
  var state: State { get }
  func trigger(_ input: Input)
}

//@dynamicMemberLookup
//final class AnyViewModel<State, Input>: ViewModelType {
//
//  // MARK: Stored properties
//
//  private let wrappedObjectWillChange: () -> AnyPublisher<Void, Never>
//  private let wrappedState: () -> State
//  private let wrappedTrigger: (Input) -> Void
//
//  // MARK: Computed properties
//
//  var objectWillChange: AnyPublisher<Void, Never> {
//    wrappedObjectWillChange()
//  }
//
//  var state: State {
//    wrappedState()
//  }
//
//  // MARK: Methods
//
//  func trigger(_ input: Input) {
//    wrappedTrigger(input)
//  }
//
//  subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
//    state[keyPath: keyPath]
//  }
//
//  // MARK: Initialization
//
//  init<V: ViewModelType>(_ viewModel: V) where V.State == State, V.Input == Input {
//    self.wrappedObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
//    self.wrappedState = { viewModel.state }
//    self.wrappedTrigger = viewModel.trigger
//  }
//
//}
//
//extension AnyViewModel: Identifiable where State: Identifiable {
//  var id: State.ID {
//    state.id
//  }
//}
