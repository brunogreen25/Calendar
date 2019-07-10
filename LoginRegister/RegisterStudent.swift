//
//  RegisterStudent.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class RegisterStudent: UIViewController {
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var jmbagTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordOneTextField: UITextField!
    @IBOutlet weak var passwordTwoTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.frontImageView.image=#imageLiteral(resourceName: "teacherImage")
        }
        
    }
    @IBAction func registerButtonClicked(_ sender: Any) {

        //provjeri ima li praznih kucica
        if self.checkIfFieldsAreFull()==false {
            return
        }
        
        //provjeri koristi li student taj username
        let students: [StudentModel]?=StudentCoreDataService().getStudentsFromCD()
        ///dohvati student iz BP i spremi ih u arra students
        if let students=students {
            for student in students {
                if student.jmbag==self.jmbagTextField.text {
                    self.displayAlertMessage("JMBAG already exists!")
                    return
                }
                
                if student.username==self.usernameTextField.text {
                    self.displayAlertMessage("Username already exists!")
                    return
                }
            }
        }
        
        //provjeri koristi li profesor taj username
        let professors: [ProfessorModel]?=ProfessorCoreDataService().getProfessorsFromCD()
        ///dohvati professors iz BP i spremi ih u array students
        if let professors=professors {
            for professor in professors {
                if professor.username==self.usernameTextField.text {
                    self.displayAlertMessage("Username already exists!")
                    return
                }
            }
        }
        
        //provjeri jesu li pas1 i pas2 jednaki
        if self.passwordOneTextField.text != self.passwordTwoTextField.text {
            self.displayAlertMessage("Passwords do not match!")
            return
        }
        
        
        //spremi studenta u BP
        StudentCoreDataService().saveToMemory(StudentModel(self.usernameTextField.text, self.passwordOneTextField.text, self.nameTextField.text, self.surnameTextField.text, self.jmbagTextField.text, nil))
        
        //dodaj opcenite postavke
        UserDefaults.standard.set("student", forKey: "status")
        UserDefaults.standard.set(self.usernameTextField.text, forKey: "username")
        UserDefaults.standard.set(self.passwordOneTextField.text, forKey: "password")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        //promini prozor
        let ad=UIApplication.shared.delegate as! AppDelegate
        ad.window?.rootViewController=TabBarController()
        ad.window?.makeKeyAndVisible()
    }
    
    func checkIfFieldsAreFull() -> Bool {
        if self.surnameTextField.text=="" || self.nameTextField.text=="" || self.passwordOneTextField.text=="" || self.passwordTwoTextField.text=="" || self.usernameTextField.text=="" || self.jmbagTextField.text=="" {
            self.displayAlertMessage("All fields must be full!")
            return false
        }
        return true
    }
    
    func displayAlertMessage(_ message: String)
    {
        //HOW TO MAKE ALERT POP-UP MINI WINDOW
        var myAlert=UIAlertController(title: "OOps!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction=UIAlertAction(title: "INSERT AGAIN", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(myAlert, animated: true)
        }
    }
    
    
    
}
