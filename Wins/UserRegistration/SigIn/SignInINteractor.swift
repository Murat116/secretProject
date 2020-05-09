//
//  SignInINteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class SignInInteractor: SignInInteractorInput {
    
    func signIn(login: String, password: String) {
        
        NetworkManager._shared.checkCorrectLoginAndPassword(login, password) { boolRequest in
            
            guard let check = boolRequest, check.value == true, let id = check.id else {
                
                self.output.closeLoader()
                self.output.actionOfIncorrectLoginAndPassword()
                
                return
            }
            
            NetworkManager._shared.getUser(id: id) { user in
                //TODO: DataManager._shared.createUser(user: user)
//                DataManager._shared.createUser(user: user)
                self.output.closeLoader()
//                self.output.nextVCAfterSignIn()
            }
            
        }
    }
    
    weak var output: SignInInteractorOutput!
    
    func createUser(login: String, password: String) {
        
        NetworkManager._shared.checkOriginLogin(login) { boolRequest in
            
            self.output.closeLoader()
            
            guard let check = boolRequest, check.value == true else {
                self.output.actionOfLoginNotOrigin()
                return
            }
            
            DataManager._shared.createUser(login: login, password: password, sportType: .none)
            DataManager._shared.updateUserBackEnd()
            self.output.nextVCAfterRegistration()
        }
    }
}
