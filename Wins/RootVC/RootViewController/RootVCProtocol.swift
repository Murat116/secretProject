//
//  RootVCProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

protocol RootViewInpit: class {
    func configure(with model: User?, _ chalenges: [Challenge], and lastTenTrick: [Trick])
    func reload(with chalanges: [Challenge])
    func reload(with lastTenTrick: [Trick])
    func reload(with user: User)
}

protocol RootViewOutput: class{
    //router
    func goToSettings()
    func goToReg()
    func goToDoneChallenge()
    
    func showGameView()
    
    func technicalSkillTaped()
    
    //reloadMetods
}

protocol RootInteractorOutput: class{
    func configure(with model: User?,_ chalenges: [Challenge], and lastTenTrick: [Trick])
    
    func reload(with chalanges: [Challenge])
    func reload(with lastTenTrick: [Trick])
    func reload(with user: User)
}

protocol RootRouterInput: class{
    func goToSettings()
    func goToReg()
    func goToDoneChallenge()
    
    func showGameView()
    func showTechnicalPopover()
}

protocol RootInteractorInput {
    func getLastTenTricks() -> [Trick]
    func getUser() -> User
    func getChallenges() -> [Challenge]
}


