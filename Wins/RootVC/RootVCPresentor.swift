//
//  RootVCPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

class RootVCPresentor{
    weak var view: RootViewInpit!
    var router: RootRouterInput!
    var interactor: RootInteractorInput!
}


extension RootVCPresentor: RootViewOutput{
    //MARK: Reload metods
    
    func reloaChalanhes() {
        let challenges = self.interactor.getChallenges()
        self.view.reload(with: challenges)
    }
    
    func reloadTricks() {
        let lastTenTrick = self.interactor.getTricks()
        self.view.reload(with: lastTenTrick)
    }
    
    func reloadUser() {
        let user = self.interactor.getUser()
        self.view.reload(with: user)
    }
    
    //MARK: Save Data
    
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float) {
        self.interactor.saveTrick(trick, with: stab, and: dif)
    }
    
    func challengeDone(challenge: Challenge) {
        self.interactor.challengeDone(challenge: challenge)
    }
    
    //MARK: Router metods
    
    func recountTechnocalSkill(){
        self.interactor.recountTechnocalSkill()
    }
        
    func goToReg() {
        self.router.goToReg()
    }
    
    func goToSettings() {
        self.router.goToSettings()
    }
    
    func goToDoneChallenge() {
        self.router.goToDoneChallenge()
    }
    
}

//MARK: Configure
extension RootVCPresentor: RootInteractorOutput{
    func configure(with model: User?, _ chalenges: [Challenge], and lastTenTrick: [Trick]) {
        if model != nil{
            self.view.configure(with: model, chalenges, and: lastTenTrick)
        } else{
            self.goToReg()
        }
    }
}
