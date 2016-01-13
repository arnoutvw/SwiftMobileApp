//
//  Feedable.swift
//  devoxxApp
//
//  Created by maxday on 24.12.15.
//  Copyright © 2015 maximedavid. All rights reserved.
//

import Foundation
import CoreData
import UIKit



public protocol Feedable {
}

public protocol FeedableProtocol  {
    func feedHelper(help: DataHelperProtocol)
    func exists(id : String, leftPredicate: String, entity: String) -> Bool
}


extension Feedable where Self: FeedableProtocol {
    // Flyable birds can fly!
    func exists(id : String, leftPredicate: String, entity: String) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: entity)
        let predicate = NSPredicate(format: "\(leftPredicate) = %@", id)
        fetchRequest.predicate = predicate
        let items = try! context.executeFetchRequest(fetchRequest)
        return items.count > 0
    }
}