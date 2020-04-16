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
    func nextView() {
        if self.view.isRegistration{
            UserInfoRegistrationVC.show(parent: view)
        }else{
            self.view.dismiss(animated: true, completion: view.complition)
        }
    }
    
    func endRegistration() {
        func endRegistration(){
            self.view.complition!()
        }
    }
    
}
