//
//  CoreData.swift
//  HuntFish
//
//  Created by Chris Chares on 2/10/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import CoreData

public struct CoreData {
    // MARK: - Core Data stack
    
    public static var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.plymouthsoftware.core_data" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    public static var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    public static var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent("HuntFish")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    public static var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    public static func saveContext () throws {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                //log and rethrow the error
                NSLog("Unresolved error \(error), \(error.userInfo)")
                throw error
            }
        }
    }
    
    public static func quickSave() -> Error? {
        do {
            try saveContext()
            return nil
        } catch let error {
            print(error)
            return error
        }
    }
}

public extension CoreData {
    
    public static func purge(_ entityName: String) throws {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        let items = try managedObjectContext.fetch(fetchRequest)
        
        for item in items {
            managedObjectContext.delete(item)
        }
    }
}

/*
    Stuff from objc.io's Core Data book
*/

/*
    A wrapper to allow proper generic usage
*/
open class ManagedObject : NSManagedObject {}

public protocol ManagedObjectType {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor]? { get }
    
    static func findOrCreate<E>(_ predicate: NSPredicate) throws -> E
}

public extension ManagedObjectType {
    public static var defaultSortDescriptors: [NSSortDescriptor]? { return nil }
    
    public static var sortedFetchRequest: NSFetchRequest<ManagedObject> {
        let fetchRequest = NSFetchRequest<ManagedObject>(entityName: entityName)
        fetchRequest.sortDescriptors = defaultSortDescriptors
        return fetchRequest
    }
    
    public static func findOrCreate<E>(_ predicate: NSPredicate) throws -> E {
        let fetchRequest = NSFetchRequest<ManagedObject>(entityName: entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = predicate
        
        if let result = try CoreData.managedObjectContext.fetch(fetchRequest).first as? E {
            return result
        } else {
            let result = NSEntityDescription.insertNewObject(forEntityName: entityName, into: CoreData.managedObjectContext) as! E
            return result
        }
    }
}


