//
//  SportRegConfigurator.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import UIKit

class SportRegAssembly {
    class func configureModule() -> SportsRegVC{
        let view = SportsRegVC()
        
        let presenter = SportRegPresentor()
        let interactor = SportRegInteractor()
        let router = SportRegRouter()
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        router.view = view
        
        interactor.getData()
        
        return view
    }
}
