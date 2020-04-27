//
//  UserInfoRegInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class UserInfoRegInteractor{
    
    var user: User? = nil
    
    weak var output: UserInfoRegInteractorProtocolOutput!
    
    func getUserData(){
        self.user = DataManager._shared.getUser()
        guard let user = self.user else { return }
        self.output.configureView(with: user)
    }
}

extension UserInfoRegInteractor: UserInfoRegInteractorProtocolInput{
    func saveUserData(with user: User) {
        let dataMng = DataManager._shared
        dataMng.saveName(user.name)
        dataMng.saveCity(user.city ?? "")
        dataMng.saveAge(user.age)
        dataMng.saveStand(user.standIsRegular ? 0 : 1)
        dataMng.saveSocialNet(user.facebook, type: .facebook)
        dataMng.saveSocialNet(user.instagram, type: .instagram)
        dataMng.saveSocialNet(user.vkonakte, type: .twiter)
    }

}

