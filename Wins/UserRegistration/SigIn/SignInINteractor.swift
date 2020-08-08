//
//  SignInINteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class SignInInteractor: SignInInteractorInput {
    
    weak var output: SignInInteractorOutput!
    
    func signIn(login: String, password: String) {
        
        NetworkManager._shared.checkCorrectLoginAndPassword(login, password.hashString) { boolRequest in
            
            guard let check = boolRequest, check.value == true, let id = check.id else {
                
                self.output.closeLoader()
                self.output.actionOfIncorrectLoginAndPassword()
                
                return
            }
            
            NetworkManager._shared.getUser(id: id) { (user, error) in
                
                guard let user = user else { self.output.closeLoader(); return }
                
                DataManager._shared.createUser(user)
                
                self.output.closeLoader()
                self.output.nextVCAfterSignIn()
            }
            
        }
    }
    
    func createUser(login: String, password: String) {
        
        NetworkManager._shared.checkOriginLogin(login) { boolRequest in
            
            self.output.closeLoader()
            
            guard let check = boolRequest, check.value == true else {
                self.output.actionOfLoginNotOrigin()
                return
            }
            
            DataManager._shared.createUser(login: login, password: password.hashString, sportType: .none)
            DataManager._shared.updateUserBackEnd()
            self.output.nextVCAfterRegistration()
        }
    }
}
