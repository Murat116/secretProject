//
//  SportRegPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import UIKit

class SportRegPresentor {
//    func sportIsSelected(with type: SportsRegVC.SportType) {
//        self.interactor.saveUserData()
//        self.router.nextView()
//    }
    
    var interactor: SportRegInteractorProtocolInput!
    
    var router: SportRegRouterProtocolInput!
    
    weak var view: SportRegViewProtocolInput!
        
    func configure() {
        self.view.setUP()
        let sportType = self.interactor.getUserSport()
        let isUser = sportType != .none ? self.interactor.isUser() : false
        self.view.configure(with: sportType, and: isUser)
    }
    
}

extension SportRegPresentor: SportRegViewProtocolOutput{
    func showAlert(alert: UIAlertController) {
        self.router.showAlert(alert: alert)
    }
    
    func sportIsSelected(with type: SportType) {
        self.saveUserData(with: type)
        if self.view.isUser{
            self.router.dismiss()
        }else{
            self.router.nextView()
        }
    }
}

extension SportRegPresentor: SportRegInteractorProtocolOutput{
    
    func saveUserData(with type: SportType) {
        UserDefaults.standard.set(type.rawValue, forKey: USRDefKeys.sportType)
        
    }
}
