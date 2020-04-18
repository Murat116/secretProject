//
//  RootVCProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

protocol RootViewInpit: class {
    func configure(with model: User)
}

protocol RootViewOutput: class{
    func goToSettings()
}

protocol RootInteractorOutput: class{
    func configure(with model: User)
}

protocol RootRouterInput: class{
    func goToSettings()
}


