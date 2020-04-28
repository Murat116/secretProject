//
//  SignInPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class SignInPresentor{
    weak var view: SignInViewInput!
    var router: SignInRouterInput!
    var interactor: SignInInteractorInput!
    
    func setUpView(){
        self.view.setUp()
    }
}

extension SignInPresentor: SignInViewOutput{
    func signIn() {
        self.router.signIn()
    }
    
    func createUser(login: String, password: String) {
        self.interactor.createUser(login: login, password: password)
    }
    
    func nextVC() {
        self.router.nextVc()
    }
    
  
}
