//
//  RootViewController.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class RootViewController: UIViewController{
    
//    var _shared: RootViewController = RootViewController()
//    
//    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    internal required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
