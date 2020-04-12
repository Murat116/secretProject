//
//  SportRegPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import UIKit

class SportRegPresentor: SportRegPresentorProtocol{
    func sportIsSelected(with type: SportsRegVC.SportType) {
        self.interactor.saveUserData()
        self.router.nextView()
    }
    
    var interactor: SportRegInteractorProtocol!
    
    var router: SportRegRouterProtocol!
    
    var view: SportRegViewProtocol!
        
    func configure() {
        self.view.setUP()
    }
    
    required init(view: SportRegViewProtocol) {
        self.view = view
    }
}
