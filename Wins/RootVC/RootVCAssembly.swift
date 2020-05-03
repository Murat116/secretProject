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
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = view
        interactor.output = presenter
        view.output = presenter
        view.headerView.output = presenter
        interactor.locationManager = LocationManager(delegate: interactor)
        
        interactor.getUserData()
        
        return view
    }
}
