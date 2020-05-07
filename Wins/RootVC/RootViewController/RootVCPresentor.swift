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
    
    func technicalSkillTaped() {
        self.router.showTechnicalPopover()
    }
    
    //MARK: Router metods
    
    func goToReg() {
        self.router.goToReg()
    }
    
    func goToSettings() {
        self.router.goToSettings()
    }
    
    func goToDoneChallenge() {
        self.router.goToDoneChallenge()
    }
    
    func showGameView() {
        self.router.showGameView()
    }
    
    
}

//MARK: Configure
extension RootVCPresentor: RootInteractorOutput{
    func reload(with chalanges: [Challenge]) {
        self.view.reload(with: chalanges)
    }
    
    func reload(with lastTenTrick: [Trick]) {
        self.view.reload(with: lastTenTrick)
    }
    
    func reload(with user: User) {
        self.view.reload(with: user)
    }
    
    func configure(with model: User?, _ chalenges: [Challenge], and lastTenTrick: [Trick]) {
        if model != nil{
            self.view.configure(with: model, chalenges, and: lastTenTrick)
        } else{
            self.goToReg()
        }
    }
}
