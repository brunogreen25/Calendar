//
//  ChooseGroupCell.swift
//  Calendar
//
//  Created by Five on 6/21/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit

class ChooseGroupCell: UITableViewCell {
    
    
    @IBOutlet weak var attendButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    var subjectID: String=""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func attendButtonClicked(_ sender: Any) {
        ///dodaj kod koji ce u studenta sa usernameon iz UserDefaultsa dodat ovaj subjectID
        
        SubjectCoreDataService().updateStudentsInSubject(subjectID: self.subjectID, studentUsername: UserDefaults.standard.string(forKey: "username")!)
        
        let vc = TabBarController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
