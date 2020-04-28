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
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float) {
        self.interactor.saveTrick(trick, with: stab, and: dif)
    }
    
    func recountTechnocalSkill(){
        self.interactor.recountTechnocalSkill()
    }
        
    func goToReg() {
        self.router.goToReg()
    }
    
    func goToSettings() {
        self.router.goToSettings()
    }
    
}

extension RootVCPresentor: RootInteractorOutput{
    func reloadData() {
        let lastTenTrick = self.interactor.getTricks()
        let user = self.interactor.getUser()
        self.configure(with: user, and: lastTenTrick)
        
    }
    
    func configure(with model: User?, and lastTenTrick: [Trick]) {
        if model != nil{
            self.view.configure(with: model, and: lastTenTrick)
        } else{
            self.goToReg()
        }
    }
}
