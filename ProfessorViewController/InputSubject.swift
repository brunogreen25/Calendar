//
//  InputSubject.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class InputSubject: UIViewController {
    @IBOutlet weak var subjectNameTextField: UITextField!
    
    @IBOutlet weak var mondayBTimeTextField: UITextField!
    @IBOutlet weak var tuesdayBTimeTextField: UITextField!
    
    @IBOutlet weak var wednesdayBTimeTextField: UITextField!
    
    @IBOutlet weak var thursdayBTimeTextField: UITextField!
    
    @IBOutlet weak var fridayBTimeTextField: UITextField!
    
    @IBOutlet weak var placeTextField: UITextField!
    
    @IBOutlet weak var mondayETimeTextField: UITextField!
    @IBOutlet weak var tuesdayETimeTextField: UITextField!
    
    @IBOutlet weak var wednesdayETimeTextField: UITextField!
    
    @IBOutlet weak var thursdayETimeTextField: UITextField!
    
    @IBOutlet weak var fridayETimeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func publishSubjectButtonClicked(_ sender: Any) {
        let db=SubjectCoreDataService().getSubjectsFromCD()
        let profUsername=UserDefaults.standard.string(forKey: "username")
        
        //nemoze isti profesor dodat jos jedan predmet s istim imenom
        for subject in db {
            if subject.name==self.subjectNameTextField.text {
                if subject.professorUsername==profUsername {
                    self.displayAlertMessage("Cannot input same subject!")
                    return
                }
            }
        }
        
        //generiranje subjectID
        var again: Bool
        var id: String
        repeat{
            again=false
            id=String(Int.random(in: 0...1000))
            
            for subject in db {
                if subject.id==id {
                    again=true
                }
            }
        }while again
        
        //spremanje subjecta u BP
        if self.mondayBTimeTextField.text=="" {
            self.mondayBTimeTextField.text="0.00"
        }
        if self.mondayETimeTextField.text=="" {
            self.mondayETimeTextField.text="0.00"
        }
        var time=self.mondayBTimeTextField.text ?? "0.00"
        time+=";"
        time+=self.mondayETimeTextField.text ?? "0.00"
        time+="|"
    
        if self.tuesdayBTimeTextField.text=="" {
            self.tuesdayBTimeTextField.text="0.00"
        }
        if self.tuesdayETimeTextField.text=="" {
            self.tuesdayETimeTextField.text="0.00"
        }
        time+=self.tuesdayBTimeTextField.text ?? "0.00"
        time+=";"
        time+=self.tuesdayETimeTextField.text ?? "0.00"
        time+="|"
        
        if self.wednesdayBTimeTextField.text=="" {
            self.wednesdayBTimeTextField.text="0.00"
        }
        if self.wednesdayETimeTextField.text=="" {
            self.wednesdayETimeTextField.text="0.00"
        }
        time+=self.wednesdayBTimeTextField.text ?? "0.00"
        time+=";"
        time+=self.wednesdayETimeTextField.text ?? "0.00"
        time+="|"
        
        if self.thursdayBTimeTextField.text=="" {
            self.thursdayBTimeTextField.text="0.00"
        }
        if self.thursdayETimeTextField.text=="" {
            self.thursdayETimeTextField.text="0.00"
        }
        time+=self.thursdayBTimeTextField.text ?? "0.00"
        time+=";"
        time+=self.thursdayETimeTextField.text ?? "0.00"
        time+="|"
        
        if self.fridayBTimeTextField.text=="" {
            self.fridayBTimeTextField.text="0.00"
        }
        if self.fridayETimeTextField.text=="" {
            self.fridayETimeTextField.text="0.00"
        }
        time+=self.fridayBTimeTextField.text ?? "0.00"
        time+=";"
        time+=self.fridayETimeTextField.text ?? "0.00"
        time+="|"
        
        SubjectCoreDataService().saveToMemory(SubjectModel(id, self.subjectNameTextField.text, nil, profUsername, time, self.placeTextField.text))
        
        ///DODAJ SUBJECTID U USERNAME IZ USERDEFAULTS-a
        
        self.displayAlertMessage("Subject has been added to your calendar")
        
        //resetirajView
        self.mondayBTimeTextField.text=""
        self.tuesdayBTimeTextField.text=""
        self.wednesdayBTimeTextField.text=""
        self.thursdayBTimeTextField.text=""
        self.fridayBTimeTextField.text=""

        self.mondayETimeTextField.text=""
        self.tuesdayETimeTextField.text=""
        self.wednesdayETimeTextField.text=""
        self.thursdayETimeTextField.text=""
        self.fridayETimeTextField.text=""

        self.subjectNameTextField.text=""
        self.placeTextField.text=""
        
        if SubjectCoreDataService().getSubjectsFromCD() != nil {
            print("nije nil u BP od Subject-a")
        }
    }
    
    func displayAlertMessage(_ message: String)
    {
        //HOW TO MAKE ALERT POP-UP MINI WINDOW
        var myAlert=UIAlertController(title: "!!!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction=UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(myAlert, animated: true)
        }
    }
    
}

