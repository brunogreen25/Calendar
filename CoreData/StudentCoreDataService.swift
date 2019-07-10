//
//  CoreDataService.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class StudentCoreDataService {
    
    let persistanceManager=CoreDataManager.shared
    
    func saveToMemory(_ student: StudentModel) {
        self.createStudent(student)
    }
    
    //create Core Data object
    func createStudent(_ student: StudentModel) {
        //save a Student to Core Data
        var db=Student(context: self.persistanceManager.context)
        
        db.username=student.username
        db.password=student.password
        db.firstName=student.firstName
        db.lastName=student.lastName
        db.jmbag=student.jmbag
        db.subjectIDs=nil
        
        self.persistanceManager.save()
    }
    
    func getStudentsFromCD() -> [StudentModel] {
        // guard let users=try! persistanceManager.context.fetch(Entity.fetchRequest()) as? [QuizCD] else {return}
        var students=[StudentModel]()
        //get quizzes from Core Data
        let db=self.persistanceManager.fetch(Student.self)
        
        for s in db {
            students.append(StudentModel(s.username, s.password, s.firstName, s.lastName, s.jmbag, s.subjectIDs))
        }
        return students
    }

}
