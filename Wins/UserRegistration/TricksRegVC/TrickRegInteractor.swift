//
//  TrickRegInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 10.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class TrickRegInteractor: TrickRegInteractorProtocol{
    
    weak var presentor: TrickRegPresentorProtocol!
    
    func saveUserData() {
        
    }
    
    required init(_ presentor: TrickRegPresentorProtocol){
        self.presentor = presentor
    }
    
}
