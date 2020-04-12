//
//  SportRegConfigurator.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import UIKit

class SportRegConfigurator: SportRegConfiguratorProtocol{
    func configure(with vc: SportsRegVC) {
        let presenter = SportRegPresentor(view: vc)
        let interactor = SportRegInteractor(presentor: presenter)
        let router = SportRegRouter(vc: vc)
        
        vc.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
    
    }
}
