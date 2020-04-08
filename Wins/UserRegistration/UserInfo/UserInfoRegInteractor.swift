//
//  UserInfoRegInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class UserInfoRegInteractor: UserInfoRegInteractorProtocol{
    func saveUserData() {
        //сохранить дату в realm
    }
    
    weak var presenter: UserInfoRegPresenterProtocol!
    
    required init(presenter: UserInfoRegPresenterProtocol) {
        self.presenter = presenter
    }
}

