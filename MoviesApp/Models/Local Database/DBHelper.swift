//
//  DBHelper.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import Foundation

public protocol DBHelperProtocol {
  associatedtype ObjectType
  associatedtype PredicateType
  
  func create(_ object: ObjectType)
  func fetchFirst(_ objectType: ObjectType.Type, predicate: PredicateType?) -> Result<ObjectType?, Error>
  func fetch(_ objectType: ObjectType.Type, predicate: PredicateType?, limit: Int?) -> Result<[ObjectType], Error>
  func update(_ object: ObjectType)
  func delete(_ object: ObjectType)
  func clearData(_ objectType: ObjectType.Type, predicate: NSPredicate?)
}
