//
//  Logout.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class Logout: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func logoutButtonClicked(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: "status")
        UserDefaults.standard.set(nil, forKey: "username")
        UserDefaults.standard.set(nil, forKey: "password")
        UserDefaults.standard.set(nil, forKey: "isLoggedIn")
        
        ///prikazi LoginView
        let ad=UIApplication.shared.delegate as! AppDelegate
        ad.window?.rootViewController=UINavigationController(rootViewController: Login())
        ad.window?.makeKeyAndVisible()
    }
}
