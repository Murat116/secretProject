//
//  SignInProtocols.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

internal protocol SignInViewInput: class {
    func setUp()
    
}

internal protocol SignInViewOutput: class {
    func signIn(login: String, password: String)
    func createUser(login: String, password: String)
    func nextVC()
    func showSignAlert(text: String)
    func privacyPolicyTapped()
}

internal protocol SignInRouterInput:class {
    func nextVc()
    func signIn()
    func showSignAlert(text: String)
<<<<<<< HEAD
    func showPrivacyPolicy()
=======
    func showLoader()
    func closeLoader()
>>>>>>> dev
}

internal protocol SignInInteractorInput:class {
    func signIn(login: String, password: String)
    func createUser(login: String, password: String)
}

internal protocol SignInInteractorOutput:class {
    
    func signIn()
    
    func closeLoader()
    
    func actionOfLoginNotOrigin()
    
    func actionOfIncorrectLoginAndPassword()
    
    func nextVCAfterRegistration()
    func nextVCAfterSignIn()
}
