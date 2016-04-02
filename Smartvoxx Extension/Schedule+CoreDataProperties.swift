//
//  Schedule+CoreDataProperties.swift
//  Smartvoxx
//
//  Created by Sebastien Arbogast on 04/10/2015.
//  Copyright © 2015 Epseelon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Schedule {

    @NSManaged var title: String?
    @NSManaged var href: String?
    @NSManaged var conference: Conference?
    @NSManaged var slots: NSOrderedSet?

}
