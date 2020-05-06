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
    func showGameView() {
        let gameView = GameViewAssembly.configureModule(with: self.view.view.frame)
        self.view.view.addSubview(gameView)
        
    }
    
    func goToDoneChallenge() {
        DoneChallengeVC.show(parent: view)
    }
    
    func goToReg() {
        SportsRegVC.show(parent: RootViewController._shared)
    }
    
    func goToSettings() {
        UserInfoRegistrationVC.show(parent: self.view)
    }
}
