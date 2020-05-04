//
//  StatisticsInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 20.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class StatisticInteractor{
    weak var output: StatInteractorOutput!
    
    func getTricks(){
        let tricks = DataManager._shared.skateTricks
        let arrOfTricks = Array(tricks)
        
        self.output.configure(with: arrOfTricks)
        
    }
}
