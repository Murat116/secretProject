//
//  RootVCInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class RootVCInteractor{
    weak var output: RootInteractorOutput!
    
    func getUserData(){
        let user = DataManager._shared.getUser() ?? User()
        self.output.configure(with: user)
    }
}


