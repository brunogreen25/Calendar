//
//  CalendarS.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit

class CalendarS: UIViewController {
    
    @IBOutlet weak var groupsTableView: UITableView!
    
    var subjectData = [SubjectModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ucitaj BP za predmete
        let db=SubjectCoreDataService().getSubjectsFromCD()
        for subject in db {
            if subject.studentUsernames?.contains(UserDefaults.standard.string(forKey: "username")!) ?? false {
                self.subjectData.append(SubjectModel(subject.id, subject.name, subject.studentUsernames, subject.professorUsername, subject.time, subject.place))
            }
        }
        
        self.groupsTableView.register(UINib(nibName: "CalendarSCell", bundle: nil), forCellReuseIdentifier: "CalendarSCell")
        self.groupsTableView.dataSource=self
    }
    
    override func viewDidAppear(_ animated: Bool) {
         self.groupsTableView.reloadData()
    }
}

extension CalendarS: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subjectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarSCell", for: indexPath) as! CalendarSCell
        
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
            
            text=self.subjectData[indexPath.row].name!
            text += "\n" + professorName!
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
            
            print(cell.infoLabel.text!)
        }
        
        
        return cell
    }
}
