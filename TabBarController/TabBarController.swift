//
//  TabBarController.swift
//  Calendar
//
//  Created by Five on 6/20/19.
//  Copyright © 2019 BrunoJ. All rights reserved.
//

import Foundation
import UIKit
class TabBarController: UITabBarController {
    ///ako stignes, nemoj force-unwrappat
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // primjer hijerarhije viewControllera
        // TabBarViewController sadrzi 2 UIViewControllera: UINavigationController i SettingsViewController
        // UINavigationController na svom stogu sadrzi ReviewsViewController
        
        var vc: UIViewController?=nil
        
        let status=UserDefaults.standard.string(forKey: "status")
        if status=="professor" {
            vc=CalendarP()
        }
        if status=="student" {
            vc=CalendarS()
        }
        vc!.tabBarItem = UITabBarItem(title: "Calendar", image:nil, tag: 0)
        // UIViewControlleri imaju property UINavigationItem koji nije UIView, vec objekt koji sadrzi podatke koje UINavigationController koristi pri iscrtavanju svog UINavigationBar-a
        // npr property 'title' UINavigationBar-a od ovog ReviewsViewController sadrzi naslov koji ce se ispisati u navigationBaru kada se ReviewsViewController pusha na vrh stoga UINavigationControllera (kada se prikaze na ekranu)
        vc!.navigationItem.title = "Calendar"
        
        // UIViewControlleri imaju property UITabBarItem koji sadrzi podatke koje koristi UITabBarController
        // UITabBarController koristi tabBarItem objekt da bi iscrtao tab za svaki viewController u svom arrayu viewControllera
        
        ///ZASTO SE OVI TITLE-OVI NE POJAVLJUJU??
        var vc2: UIViewController? = nil
        
        if status=="professor" {
            vc2=InputSubject()
        }
        if status=="student" {
            vc2=ChooseSubject()
        }
        let nvc2 = UINavigationController(rootViewController: vc2!)
        if status=="professor" {
            nvc2.tabBarItem=UITabBarItem(title: "Input Subject", image: nil, tag: 0)
        }
        if status=="student" {
            nvc2.tabBarItem=UITabBarItem(title: "Choose Subject", image: nil, tag: 0)
        }
        
        let vc3 = Logout()
        vc3.tabBarItem = UITabBarItem(title: "Logout", image: nil, tag: 0)
        vc3.navigationItem.title="Logout"
        
        self.viewControllers = [vc!, nvc2, vc3]
    }
    
}

