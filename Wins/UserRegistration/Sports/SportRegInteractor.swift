//
//  SportRegInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//
import Foundation

class SportRegInteractor{
    
    weak var output: SportRegInteractorProtocolOutput!
    
}

extension SportRegInteractor: SportRegInteractorProtocolInput{
    func getUserSport() -> SportType {
        guard let sportTypeValue = UserDefaults.standard.value(forKey: USRDefKeys.sportType) as? String,
            let type = SportType(rawValue: sportTypeValue) else { return .skate}
        return type
    }
}
