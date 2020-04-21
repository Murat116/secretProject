//
//  StatisticProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 20.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

protocol StatViewInput: class{
    func configure(with tricks: [Trick])
}

protocol StatInteractorOutput: class{
    func configure(with tricks: [Trick])
}
