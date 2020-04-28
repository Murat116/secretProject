//
//  UserInfoRegProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

import UIKit

protocol UserInfoRegInteractorProtocolInput: class {
    func saveUserData(with name: String, city: String, age: String, isReg: Bool)
}

protocol UserInfoRegInteractorProtocolOutput: class {
    func getUserData()
    func configureView(with user: User)
}

protocol UserInfoRegViewProtocolInput: class {
    func setUp()
    func configureView(with user: User)
}

protocol UserInfoRegViewProtocolOutput: class {
    func openNextStep()
    func openPhotoPicker()
    
    func openSportVC()
    
    func openAlert(alert: UIAlertController)
    
    func saveUserData(with name: String, city: String, age: String, isReg: Bool)
}

protocol UserInfoRegRouterProtocolInput: class {
    func closeCurrentViewController()
    func openNextStep()
    func openPhotoPicker()
    func openSportVC()
    
    func endRegistration()
    
    func openAlert(alert: UIAlertController)
}
