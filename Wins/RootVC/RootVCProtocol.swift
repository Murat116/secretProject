//
//  RootVCProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

protocol RootViewInpit: class {
    func configure(with model: User?, and lastTenTrick: [Trick])
}

protocol RootViewOutput: class{
    func goToSettings()
    func goToReg()
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float)
}

protocol RootInteractorOutput: class{
    func configure(with model: User?, and lastTenTrick: [Trick])
}

protocol RootRouterInput: class{
    func goToSettings()
    func goToReg()
}

protocol RootInteractorInput {
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float)
}


