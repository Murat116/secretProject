//
//  userInfoRegistrationAssembly.swift
//  Wins
//
//  Created by Мурат Камалов on 17.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class UserInfoRegistrationAssembly {
    class func configureModule() -> UserInfoRegistrationVC{
        let view = UserInfoRegistrationVC()
        
        let presenter = UserInfoRegPresentor()
        let interactor = UserInfoRegInteractor()
        let router = UserInfoRegRouter()
        
        view.output = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        router.view = view

        interactor.getUserData()
        
        return view
    }
}
