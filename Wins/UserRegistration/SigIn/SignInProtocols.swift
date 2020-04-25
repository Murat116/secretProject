//
//  SignInProtocols.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

internal protocol SignInViewInput: class{
    func setUp()
}

internal protocol SignInViewOutput:class{
    func createUser(login: String, password: String)
    func nextVC()
    func signIn()
}

internal protocol SignInRouterInput:class{
    func nextVc()
    func signIn()
}

internal protocol SignInInteractorInput:class{
    func createUser(login: String, password: String)
}
