//
//  SportRegProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

protocol SportRegConfiguratorProtocol {
    func configure(with VC: SportsRegVC)
}

protocol SportRegPresentorProtocol:class{
    var interactor: SportRegInteractorProtocol! { get set }
    var router: SportRegRouterProtocol! { get set }
    var view: SportRegViewProtocol! { get set}
    
    func configure()
    func sportIsSelected(with type: SportsRegVC.SportType)
}

protocol SportRegInteractorProtocol:class {
    func saveUserData()
}

protocol SportRegRouterProtocol: class{
    func nextView()
    func endRegistration()
}

protocol SportRegViewProtocol: class{
    func setUP()
}
