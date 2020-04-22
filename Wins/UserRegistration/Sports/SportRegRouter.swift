//
//  SportRegRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import UIKit

class SportRegRouter{
    
    weak var view: SportsRegVC!
        
}

extension SportRegRouter: SportRegRouterProtocolInput{
    func showAlert(alert: UIAlertController) {
        self.view.present(alert, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.view.dismiss(animated: true, completion: nil)
    }
    
    func nextView() {
        UserInfoRegistrationVC.show(parent: view)
//        DataManager._shared.createUser(login: "Murat", password: "1", sportType: .skate)
    }
    
    func endRegistration() {
 
    }
    
}
