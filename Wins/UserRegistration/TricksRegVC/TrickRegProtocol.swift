//
//  TrickRegProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 10.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

protocol TrickRegConfiguratorProtocol {
    func configure(with vc: TricksRegVC)
}

protocol TrickRegPresentorProtocol: class {
    var interactor: TrickRegInteractorProtocol! {get set}
    var router: TrickRegRouterProtocol! {get set}
    
    func configureView()
}

protocol TrickRegInteractorProtocol: class {
    func saveUserData()
}

protocol TrickRegViewProtocol: class {
    func setUpUI()
}

protocol TrickRegRouterProtocol: class {
    func endRegistration()
}
