//
//  SportRegProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//



protocol SportRegInteractorProtocolOutput:class {
    func saveUserData(with type: SportType)
}

protocol SportRegInteractorProtocolInput: class{
    func getUserSport() -> SportType
}

protocol SportRegViewProtocolInput: class{
    func setUP()
    func configure(with type: SportType)
}

protocol SportRegViewProtocolOutput: class{
    func sportIsSelected(with type: SportType)
}

protocol SportRegRouterProtocolInput: class{
    func nextView()
    func endRegistration()
}
