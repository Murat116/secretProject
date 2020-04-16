//
//  TrickRegRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 10.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class TrickRegRouter: TrickRegRouterProtocol{
    weak var vc: TricksRegVC!
    
    func endRegistration() {
        self.vc.userRegRouter.endRegistration()
    }
    
    required init(_ vc: TricksRegVC){
        self.vc = vc
    }
}
