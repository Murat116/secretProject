//
//  SignInINteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class SignInInteractor: SignInInteractorInput {
    func createUser(login: String, password: String) {
        DataManager._shared.createUser(login: login, password: password, sportType: .none)
    }
}
