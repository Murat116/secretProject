//
//  SignInPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class SignInPresentor {
    weak var view: SignInViewInput!
    var router: SignInRouterInput!
    var interactor: SignInInteractorInput!
    
    func setUpView() {
        self.view.setUp()
    }
    
}

extension SignInPresentor: SignInViewOutput {
    
<<<<<<< HEAD
=======
    func signIn(login: String, password: String) {
        
        self.router.showLoader()
        self.interactor.signIn(login: login, password: password)
    }
    
>>>>>>> dev
    func showSignAlert(text: String) {
        self.router.showSignAlert(text: text)
    }
    
    func createUser(login: String, password: String) {
        
        self.router.showLoader()
        self.interactor.createUser(login: login, password: password)
    }
    
    func nextVC() {
        self.router.nextVc()
    }

}
extension SignInPresentor: SignInInteractorOutput {
    
    func signIn() {
        self.router.signIn()
    }
    
    func closeLoader() {
        self.router.closeLoader()
    }
    
    func actionOfLoginNotOrigin() {
        self.router.showSignAlert(text: "User with this Login already exists")
    }
    
    func actionOfIncorrectLoginAndPassword() {
        self.router.showSignAlert(text: "Incorrect login or password")
    }
    
    func nextVCAfterRegistration() {
        self.router.nextVc()
    }
    
<<<<<<< HEAD
    func privacyPolicyTapped() {
        self.router.showPrivacyPolicy()
        //self.view.showPolicy()
=======
    func nextVCAfterSignIn() {
        self.router.signIn()
>>>>>>> dev
    }
}
