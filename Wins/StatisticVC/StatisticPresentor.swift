//
//  StatisticPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 20.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class StatisticPresentor{
    weak var view: StatViewInput!
}

extension StatisticPresentor: StatInteractorOutput{
    func configure(with tricks: [Trick]) {
        self.view.configure(with: tricks)
    }
}
