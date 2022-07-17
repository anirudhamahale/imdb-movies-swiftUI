//
//  CoreDataHelper.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//

import Foundation
import CoreData

class CoreDataHelper: DBHelperProtocol {
  
  static let shared = CoreDataHelper()
  
  typealias ObjectType = NSManagedObject
  typealias PredicateType = NSPredicate
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Movies")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Unable to load persistent stores: \(error)")
      }
    }
    return container
  }()
  
  var context: NSManagedObjectContext {
    persistentContainer.viewContext
  }
  
  func create(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {
      print("error saving context while creating an object")
    }
  }
  
  func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
    let request = objectType.fetchRequest()
    request.predicate = predicate
    request.fetchLimit = 1
    do {
      let result = try context.fetch(request) as? [T]
      return .success(result?.first)
    } catch {
      return .failure(error)
    }
  }
  
  func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, limit: Int? = nil) -> Result<[T], Error> {
    let request = objectType.fetchRequest()
    request.predicate = predicate
    if let limit = limit {
      request.fetchLimit = limit
    }
    do {
      let result = try context.fetch(request)
      return .success(result as? [T] ?? [])
    } catch {
      return .failure(error)
    }
  }
  
  func update(_ object: NSManagedObject) {
    do {
      try context.save()
    } catch {
      print("error saving context while updating an object")
    }
  }
  
  func delete(_ object: NSManagedObject) {
    context.delete(object)
  }
  
  func clearData<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) {
    let request = objectType.fetchRequest()
    request.predicate = predicate
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
    
    do {
      try context.execute(deleteRequest)
    } catch {
      print("error executing context while clearing an entity")
    }
  }
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        print("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
}
