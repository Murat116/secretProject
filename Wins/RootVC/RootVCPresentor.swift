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
}


extension RootVCPresentor: RootViewOutput{
    func goToSettings() {
        self.router.goToSettings()
    }
    
    
}

extension RootVCPresentor: RootInteractorOutput{
    func configure(with model: User?) {
        self.view.configure(with: model)
    }
}
