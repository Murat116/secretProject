//
//  RootVCProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

protocol RootViewInpit: class {
    func configure(with model: User?, and lastTenTrick: [Trick])
    func reload(with chalanges: [Challenge])
    func reload(with lastTenTrick: [Trick])
    func reload(with user: User)
}

protocol RootViewOutput: class{
    //router
    func goToSettings()
    func goToReg()
    
    //save metods
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float)
    func challengeDone(challenge: Challenge)
    
    //reloadMetods
    func reloaChalanhes()
    func reloadTricks()
    func reloadUser()
    func recountTechnocalSkill()
}

protocol RootInteractorOutput: class{
    func configure(with model: User?,_ chalenges: [Challenge], and lastTenTrick: [Trick])
}

protocol RootRouterInput: class{
    func goToSettings()
    func goToReg()
}

protocol RootInteractorInput {
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float)
    func challengeDone(challenge: Challenge)
    func getTricks() -> [Trick]
    func getUser() -> User
    func getChallenges() -> [Challenge]
    func recountTechnocalSkill()
}


