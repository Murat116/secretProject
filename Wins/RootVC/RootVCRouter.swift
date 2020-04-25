//
//  RootVCRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class RootVCRouter{
    weak var view: RootViewController!
}

extension RootVCRouter: RootRouterInput{
    func goToReg() {
        SportsRegVC.show(parent: RootViewController._shared)
        DataManager._shared.createUser(login: nil, password: nil, sportType: .skate)
    }
    
    func goToSettings() {
        UserInfoRegistrationVC.show(parent: self.view)
    }
}