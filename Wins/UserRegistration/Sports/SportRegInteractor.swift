//
//  SportRegInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

class SportRegInteractor: SportRegInteractorProtocol{
    
    weak var presentor: SportRegPresentorProtocol!
    
    func saveUserData() {
        
    }
    
    required init(presentor: SportRegPresentorProtocol){
        self.presentor = presentor
    }
    
}
