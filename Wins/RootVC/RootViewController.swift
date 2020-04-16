//
//  RootViewController.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class RootViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let isGuest = true
        if isGuest{
            SportsRegVC.show(parent: self) {
                self.dismiss(animated: true, completion: nil)
            }
//            UserInfoRegistrationVC.show(parent: self)
        }
        
    }
}
