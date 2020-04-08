//
//  UserInfoRegProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

protocol UserInfoRegPresenterProtocol: class {
    var router: UserInfoRegRouterProtocol! { set get }
    var interactor: UserInfoRegInteractorProtocol! {set get}
    func configureView()
    
    func nextBtnAction()
    func openPhotoPicker()
}

protocol UserInfoRegConfiguratorProtocol {
    func configure(with VC: UserInfoRegistrationVC)
}

protocol UserInfoRegInteractorProtocol: class {
    func saveUserData()
}

protocol UserInfoRegViewProtocol: class {
    func setUp(with step: Int)
}

protocol UserInfoRegRouterProtocol: class {
    func closeCurrentViewController()
    func openNextStep()
    func openPhotoPicker()
}
