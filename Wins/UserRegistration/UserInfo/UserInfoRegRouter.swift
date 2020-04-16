//
//  UserInfoRegRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 08.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class UserInfoRegRouter: UserInfoRegRouterProtocol{
    
    weak var viewController: UserInfoRegistrationVC!
    
    init(viewController: UserInfoRegistrationVC) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
//        self.viewController.sportRegRouter?.endRegistration()
    }
    
    func openNextStep() {
        TricksRegVC.show(parent: self.viewController, userRegRouter: self)
    }
    
    func endRegistration(){
//        self.viewController.sportRegRouter?.endRegistration()
    }
    
    func openPhotoPicker() {
        //
    }
    
    func openSportVC() {
        let sportVC =  SportsRegVC()
        viewController.present(sportVC, animated: true, completion: nil)
    }
    
    
}
