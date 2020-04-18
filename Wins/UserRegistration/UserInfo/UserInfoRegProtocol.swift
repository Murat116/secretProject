//
//  UserInfoRegProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

protocol UserInfoRegInteractorProtocolInput: class {
    func saveUserData(with user: User)
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
    
    func saveUserData(with user: User)
}

protocol UserInfoRegRouterProtocolInput: class {
    func closeCurrentViewController()
    func openNextStep()
    func openPhotoPicker()
    func openSportVC()
    
    func endRegistration()
}
