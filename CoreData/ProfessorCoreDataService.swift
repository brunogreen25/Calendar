//
//  CoreDataService.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class ProfessorCoreDataService {
    
    let persistanceManager=CoreDataManager.shared
    
    func saveToMemory(_ professor: ProfessorModel) {
        self.createProfessor(professor)
    }
    
    //create Core Data object
    func createProfessor(_ professor: ProfessorModel) {
        //save a Student to Core Data
        var db=Professor(context: self.persistanceManager.context)
        
        db.username=professor.username
        db.password=professor.password
        db.firstName=professor.firstName
        db.lastName=professor.lastName
        db.subjectIDs=nil
        
        self.persistanceManager.save()
    }
    
    
    func getProfessorsFromCD() -> [ProfessorModel] {
        // guard let users=try! persistanceManager.context.fetch(Entity.fetchRequest()) as? [QuizCD] else {return}
        var professors=[ProfessorModel]()
        //get quizzes from Core Data
        let db=self.persistanceManager.fetch(Professor.self)
        
        for p in db {
            professors.append(ProfessorModel(p.username, p.password, p.firstName, p.lastName, p.subjectIDs))
        }
        
        return professors
    }
    
}
