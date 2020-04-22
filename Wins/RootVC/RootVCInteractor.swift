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
        let user = DataManager._shared.getUser()
        var lastTenTrick = UserDefaults.standard.value(forKey: USRDefKeys.lastTenTrick) as? [Trick]
        if lastTenTrick == nil{
            guard let tricks = user?.skateTrick else { return }
            lastTenTrick = GameView.rundomTrick(tricks: Array(tricks))
            UserDefaults.standard.set(lastTenTrick!, forKey: USRDefKeys.lastTenTrick)
        }
        self.output.configure(with: user, and: lastTenTrick!)
        
    }
    
}
extension RootVCInteractor: RootInteractorInput{
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float) {
        DataManager._shared.saveTrik(trick: trick, stab: stab, dif: dif)
    }
}


