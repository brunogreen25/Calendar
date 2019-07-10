//
//  ChooseGroup.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class ChooseGroup: UIViewController {
    
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBOutlet weak var groupsTableView: UITableView!
    
    var subjectName: String=""
    
    var subjectData = [SubjectModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //postavi naslov
        DispatchQueue.main.async {
            self.subjectNameLabel.text=self.subjectName
        }
        
        //ucitaj BP za predmete
        let db=SubjectCoreDataService().getSubjectsFromCD()
        for subject in db {
            if subject.name==self.subjectName {
                self.subjectData.append(SubjectModel(subject.id, subject.name, subject.studentUsernames, subject.professorUsername, subject.time, subject.place))
            }
        }
        
        self.groupsTableView.register(UINib(nibName: "ChooseGroupCell", bundle: nil), forCellReuseIdentifier: "ChooseGroupCell")
        self.groupsTableView.dataSource=self
        self.groupsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.groupsTableView.reloadData()
    }
}

extension ChooseGroup: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.subjectData.count)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseGroupCell", for: indexPath) as! ChooseGroupCell
        
        //referenca na bas ovu celiju
        let thisCellData=self.subjectData[indexPath.row]
        
        //pronadji kako se zove profesor za bas ovu celiju
        var professorName: String?
        let dbp=ProfessorCoreDataService().getProfessorsFromCD()
        for prof in dbp {
            if prof.username==thisCellData.professorUsername {
                professorName=prof.lastName! + " " + prof.firstName!
                break
            }
        }
        
        //dodaj vrijednosti u celiju
        DispatchQueue.main.async {
            var timeForOneDay: String
            var text: String
            
            print("EOOOO "+thisCellData.time!)
            
            text=professorName!
            text += String("\n" + thisCellData.place!)
            
            //dodaj vrime
            timeForOneDay="Monday: " + String(thisCellData.time!.split(separator: "|")[0].split(separator: ";")[0])
            timeForOneDay += "-" + String(thisCellData.time!.split(separator: "|")[0].split(separator: ";")[1])
            if timeForOneDay != "Monday: 0.00-0.00" {
                text += "\n\n" + timeForOneDay
            }
            
            timeForOneDay="Tuesday: " + String(thisCellData.time!.split(separator: "|")[1].split(separator: ";")[0])
            timeForOneDay += "-" + String(thisCellData.time!.split(separator: "|")[1].split(separator: ";")[1])
            if timeForOneDay != "Tuesday: 0.00-0.00" {
                text += "\n" + timeForOneDay
            }
                
            timeForOneDay="Wednesday: " + String(thisCellData.time!.split(separator: "|")[2].split(separator: ";")[0])
            timeForOneDay += "-" + String(thisCellData.time!.split(separator: "|")[2].split(separator: ";")[1])
            if timeForOneDay != "Wednesday: 0.00-0.00" {
                text += "\n" + timeForOneDay
            }
            
            timeForOneDay="Thursday: " + String(thisCellData.time!.split(separator: "|")[3].split(separator: ";")[0])
            timeForOneDay += "-" + String(thisCellData.time!.split(separator: "|")[3].split(separator: ";")[1])
            if timeForOneDay != "Thursday: 0.00-0.00" {
                text += "\n" + timeForOneDay
            }
            
            timeForOneDay="Friday: " + String(thisCellData.time!.split(separator: "|")[4].split(separator: ";")[0])
            timeForOneDay += "-" + String(thisCellData.time!.split(separator: "|")[4].split(separator: ";")[1])
            if timeForOneDay != "Friday: 0.00-0.00" {
                text += "\n" + timeForOneDay
            }
            
            cell.infoLabel.text=text
            cell.subjectID=self.subjectData[indexPath.row].id!
            
            self.disableButton(cell)
            
            print(cell.infoLabel.text!)
        }
        
        
        return cell
    }
    
    func disableButton(_ cell: ChooseGroupCell) {
        let db=SubjectCoreDataService().getSubjectsFromCD()
        for subject in db {
            if subject.studentUsernames?.contains(UserDefaults.standard.string(forKey: "username")!) ?? false {
                
                if subject.id!==cell.subjectID {
                    DispatchQueue.main.async {
                        cell.attendButton.isEnabled=false
                        cell.attendButton.backgroundColor=UIColor.red
                    }
                }
            }
        }
    }
    
}
