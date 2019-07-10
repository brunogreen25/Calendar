//
//  LoginView.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class Login: UIViewController {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerSButton: UIButton!
    @IBOutlet weak var registerPButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.frontImageView.image=#imageLiteral(resourceName: "login")
        }
        
        let isLoggedIn=UserDefaults.standard.bool(forKey: "isLoggedIn")
        if isLoggedIn==true {
            let ad=UIApplication.shared.delegate as! AppDelegate
            ad.window?.rootViewController=TabBarController()
            ad.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        let students: [StudentModel]?=StudentCoreDataService().getStudentsFromCD()
        
        if let students=students {
            for student in students {
                if student.username==self.usernameTextField.text {
                    if student.password==self.passwordTextField.text {
                        
                        UserDefaults.standard.set("student", forKey: "status")
                        UserDefaults.standard.set(student.username, forKey: "username")
                        UserDefaults.standard.set(student.password, forKey: "password")
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        
                        let ad=UIApplication.shared.delegate as! AppDelegate
                        ad.window?.rootViewController=TabBarController()
                        ad.window?.makeKeyAndVisible()
                    }
                }
            }
        }
        
        let professors: [ProfessorModel]?=ProfessorCoreDataService().getProfessorsFromCD()

        if let professors=professors {
            for professor in professors {
                if professor.username==self.usernameTextField.text {
                    if professor.password==self.passwordTextField.text {
                        
                        UserDefaults.standard.set("professor", forKey: "status")
                        UserDefaults.standard.set(professor.username, forKey: "username")
                        UserDefaults.standard.set(professor.password, forKey: "password")
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        
                        let ad=UIApplication.shared.delegate as! AppDelegate
                        ad.window?.rootViewController=TabBarController()
                        ad.window?.makeKeyAndVisible()
                    }
                }
            }
        }
        
        self.displayAlertMessage("Incorrect password!")
        
        
        
    }
    
    @IBAction func registerSButtonClicked(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterStudent(), animated: true)
    }
    @IBAction func registerPButtonClicked(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterProfessor(), animated: true)
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
