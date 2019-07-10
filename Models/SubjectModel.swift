//
//  SubjectModel.swift
//  Calendar
//
//  Created by Five on 6/21/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
class SubjectModel {
    
    var id: String?
    var name: String?
    var studentUsernames: String?
    var professorUsername: String?
    var time: String?
    var place: String?
    
    init(_ id: String?, _ name: String?, _ studentUsernames: String?, _ professorUsername: String?, _ time: String?, _ place: String?) {
        self.id=id
        self.name=name
        self.studentUsernames=studentUsernames
        self.professorUsername=professorUsername
        self.time=time
        self.place=place
    }
}
