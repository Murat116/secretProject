//
//  SignInAssembly.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class SignInAssembly {
    class func configureModule() -> SignInVIewController {
        
        let view = SignInVIewController()
        
        let presentor = SignInPresentor()
        let interactor = SignInInteractor()
        let router = SignInRouter()
        
        view.output = presentor
        
        presentor.view = view
        presentor.interactor = interactor
        presentor.router = router
        
        router.view = view
        
        interactor.output = presentor
        
        presentor.setUpView()
        
        return view
    }
}
