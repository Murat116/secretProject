//
//  UserInfoRegPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//


class UserInfoRegPresentor {
    weak var view: UserInfoRegViewProtocolInput!
    var router: UserInfoRegRouterProtocolInput!
    var interactor: UserInfoRegInteractorProtocolInput!
    
    func configure(){
        self.view.setUp()
    }
}

extension UserInfoRegPresentor: UserInfoRegViewProtocolOutput{
    func openSportVC() {
        self.router.openSportVC()
    }
    
    
    func openNextStep() {
        self.router.openNextStep()
    }
    
    func openPhotoPicker() {
        //открывать фото пикер
    }
    
    func saveUserData(with user: User) {
        self.interactor.saveUserData(with: user)
    }
}

extension UserInfoRegPresentor: UserInfoRegInteractorProtocolOutput{
    func configureView(with user: User) {
        self.view.configureView(with: user)
    }
    
    func getUserData(){
        
    }
}
