//
//  UserInfoRegPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class UserInfoRegPresentor {
    weak var view: UserInfoRegViewProtocolInput!
    var router: UserInfoRegRouterProtocolInput!
    var interactor: UserInfoRegInteractorProtocolInput!
}


extension UserInfoRegPresentor: UserInfoRegViewProtocolOutput {
    func privacyPolicyTapped() {
        self.router.showPrivacyPolicy()
    }
    
    
    func saveUserData(with name: String, city: String, age: String, isReg: Bool) {
        self.interactor.saveUserData(with: name, city: city, age: age, isReg: isReg)
    }
    
    func openAlert(alert: UIAlertController) {
        self.router.openAlert(alert: alert)
    }
    
    func openSportVC() {
        self.router.openSportVC()
    }
    
    
    func openNextStep() {
        self.router.openNextStep()
    }
    
    func openPhotoPicker() {
        self.router.openPhotoPicker()
    }

    func openCameraPicker() {
        self.router.openCameraPicker()
    }
    
    func setUserImage(image: UIImage) {
        self.interactor.setUserImage(image: image)
    }
    
}

extension UserInfoRegPresentor: UserInfoRegInteractorProtocolOutput{
    
    func configureView(with user: User) {
        self.view.configureView(with: user)
    }
    
    func getUserData(){
        
    }
}
