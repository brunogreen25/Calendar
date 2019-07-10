//
//  Subject+CoreDataProperties.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var studentUsernames: String?
    @NSManaged public var professorUsername: String?
    @NSManaged public var time: String?
    @NSManaged public var place: String?

}
