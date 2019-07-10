//
//  ChooseSubject.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class ChooseSubject: UIViewController {
    
    @IBOutlet weak var subjectTableView: UITableView!
    
    var subjectData = [SubjectModel]()
    var subjectCDService=SubjectCoreDataService()
    
    //var professorData=[ProfessorModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //ucitaj profesore
        let dbp=ProfessorCoreDataService().getProfessorsFromCD()
        for prof in dbp {
            self.professorData.append(ProfessorModel(prof.username, prof.password, prof.firstName, prof.lastName, prof.subjectIDs))
        }*/
        
        let dbs=self.subjectCDService.getSubjectsFromCD()
        var skip: Bool
        for subject in dbs {
            skip = false
            //nedodaji one sa istim imenom
            self.subjectData.map{
                if subject.name==$0.name {
                    skip=true
                }
            }
            if !skip {
                self.subjectData.append(SubjectModel(subject.id, subject.name, subject.studentUsernames, subject.professorUsername, subject.time, subject.place))
            }
        }
        
        self.subjectTableView.register(UINib(nibName: "ChooseSubjectCell", bundle: nil), forCellReuseIdentifier: "ChooseSubjectCell")
        
        self.subjectTableView.delegate=self
        self.subjectTableView.dataSource=self
        
        self.subjectTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.subjectTableView.reloadData()
    }
}
extension ChooseSubject: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = ChooseGroup()
        
        //prebaci data na sljedeci view
        nextView.subjectName=self.subjectData[indexPath.row].name!
        
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.subjectData.count)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseSubjectCell", for: indexPath) as! ChooseSubjectCell
        
        DispatchQueue.main.async {
            cell.subjectNameLabel.text=self.subjectData[indexPath.row].name
        }
        
        return cell
    }
    
}
