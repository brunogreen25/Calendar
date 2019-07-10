//
//  CoreDataService.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class SubjectCoreDataService {
    
    let persistanceManager=CoreDataManager.shared
    
    func saveToMemory(_ subject: SubjectModel) {
        self.createSubject(subject)
    }
    
    //create Core Data object
    func createSubject(_ subject: SubjectModel) {
        //save a Student to Core Data
        var db=Subject(context: self.persistanceManager.context)
        
        db.id=subject.id
        db.name=subject.name
        db.studentUsernames=subject.studentUsernames
        db.professorUsername=subject.professorUsername
        db.time=subject.time
        db.place=subject.place
        
        self.persistanceManager.save()
    }
    
    func getSubjectsFromCD() -> [SubjectModel] {
        // guard let users=try! persistanceManager.context.fetch(Entity.fetchRequest()) as? [QuizCD] else {return}
        var subjects=[SubjectModel]()
        //get quizzes from Core Data
        let db=self.persistanceManager.fetch(Subject.self)
        
        for s in db {
            subjects.append(SubjectModel(s.id, s.name, s.studentUsernames, s.professorUsername, s.time, s.place))
        }
        
        return subjects
    }
    
    func deleteSubject(_ name: String) {
        
        let db=self.persistanceManager.fetch(Subject.self)
        for s in db {
            if s.name! == name {
                persistanceManager.delete(s)
            }
        }
    }
    
    func updateStudentsInSubject(subjectID subjectID: String, studentUsername studentUsername: String) {
        let db=self.persistanceManager.fetch(Subject.self)
        
        db.map{
            if $0.id!==subjectID && ($0.studentUsernames?.contains(UserDefaults.standard.string(forKey: "username")!) ?? false)==false  {
                let studentUsernames=String($0.studentUsernames ?? "") + ";" + String(studentUsername)
                $0.studentUsernames=studentUsernames
            }
        }
        
        self.persistanceManager.save()
    }
    
    
}
