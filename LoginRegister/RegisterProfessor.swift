//
//  RegisterProfessor.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class RegisterProfessor: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordOneTextField: UITextField!
    @IBOutlet weak var passwordTwoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.imageView.image=#imageLiteral(resourceName: "studentRegister")
        }
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        
        //provjeri jesu li sve kucice pune
        if self.checkIfFieldsAreFull()==false {
            return
        }
        
        //provjeri koristi li student taj username
        let students: [StudentModel]?=StudentCoreDataService().getStudentsFromCD()
        if let students=students {
            for student in students {
                if student.username==self.usernameTextField.text {
                    self.displayAlertMessage("Username already exists!")
                    return
                }
            }
        }
        
        //provjeri koristi li profesor taj username
        let professors: [ProfessorModel]?=ProfessorCoreDataService().getProfessorsFromCD()
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
        
        //spremi profesora u BP
        ProfessorCoreDataService().saveToMemory(ProfessorModel(self.usernameTextField.text, self.passwordOneTextField.text, self.firstNameTextField.text, self.lastNameTextField.text, nil))
        
        //dodaj opcenite postavke
        UserDefaults.standard.set("professor", forKey: "status")
        UserDefaults.standard.set(self.usernameTextField.text, forKey: "username")
        UserDefaults.standard.set(self.passwordTwoTextField.text, forKey: "password")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        //promini prozor
        let ad=UIApplication.shared.delegate as! AppDelegate
        ad.window?.rootViewController=TabBarController()
        ad.window?.makeKeyAndVisible()
    }
    
    func checkIfFieldsAreFull() -> Bool {
        if self.lastNameTextField.text=="" || self.firstNameTextField.text=="" || self.passwordOneTextField.text=="" || self.passwordTwoTextField.text=="" || self.usernameTextField.text=="" {
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
