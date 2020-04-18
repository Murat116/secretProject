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
    func dismiss() {
        self.view.dismiss(animated: true, completion: nil)
    }
    
    func nextView() {
        UserInfoRegistrationVC.show(parent: view)
    }
    
    func endRegistration() {
        func endRegistration(){
            self.view.complition!()
        }
    }
    
}
