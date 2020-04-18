//
//  RootVCAssembly.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

class RootVCRegAssembly {
    class func configureModule() -> RootViewController{
        let view = RootViewController._shared
        
        let presenter = RootVCPresentor()
        let interactor = RootVCInteractor()
        let router = RootVCRouter()
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        
        router.view = view
        interactor.output = presenter
        
        interactor.getUserData()
        
        return view
    }
}
