//
//  Alert.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class Alert {
    static func displayAlertMessage(_ message: String)
    {
        //HOW TO MAKE ALERT POP-UP MINI WINDOW
        var myAlert=UIAlertController(title: "OOps!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction=UIAlertAction(title: "UNESI PONOVO", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        DispatchQueue.main.async {
           // self.present(myAlert, animated: true)
        }
    }
}
