//
//  TrickRegConfigurator.swift
//  Wins
//
//  Created by Мурат Камалов on 10.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class TrickRegConfigurator: TrickRegConfiguratorProtocol{
    
    func configure(with vc: TricksRegVC) {
        let presenter = TrickRegPresentor(view: vc)
        let interactor = TrickRegInteractor(presenter)
        let router = TrickRegRouter(vc)
        
        vc.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
