//
//  Professor+CoreDataProperties.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//
//

import Foundation
import CoreData


extension Professor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Professor> {
        return NSFetchRequest<Professor>(entityName: "Professor")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var subjectIDs: String?

}
