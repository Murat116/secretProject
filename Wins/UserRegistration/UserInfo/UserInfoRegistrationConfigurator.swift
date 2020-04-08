//
//  UserInfoRegistrationConfigurator.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//



class UserInfoRegConfigirator: UserInfoRegConfiguratorProtocol {
    func configure(with vc: UserInfoRegistrationVC) {
        let presenter = UserInfoRegPresentor(view: vc)//AboutPresenter(view: viewController)
        let interactor = UserInfoRegInteractor(presenter: presenter)
        let router = UserInfoRegRouter(viewController: vc)
        
        vc.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
