//
//  StudentModel.swift
//  Calendar
//
//  Created by Five on 6/21/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
class StudentModel {
    
    var username: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var jmbag: String?
    var subjectIDs: String?
    
    init(_ username: String?, _ password: String?, _ firstName: String?, _ lastName: String?, _ jmbag: String?, _ subjectIDs: String?) {
        self.username=username
        self.password=password
        self.firstName=firstName
        self.lastName=lastName
        self.jmbag=jmbag
        self.subjectIDs=subjectIDs
    }
}
