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
        let lastTricks = self.getTricks()
        self.output.configure(with: user, and: lastTricks)
    }
    
}
extension RootVCInteractor: RootInteractorInput{
    func getTricks() -> [Trick] {
        let user = DataManager._shared.getUser()
        var lastTenTrick = DataManager._shared.lastTenTrick
        if lastTenTrick.isEmpty{
            guard let tricks = user?.skateTrick else { return []}
            lastTenTrick = GameView.rundomTrick(tricks: Array(tricks))
            var lastTenTrickID = [String]()
            lastTenTrick.forEach { (trick) in
                lastTenTrickID.append(trick.name)
            }
            UserDefaults.standard.set(lastTenTrickID, forKey: USRDefKeys.lastTenTrick)
        }
        return lastTenTrick
    }
    
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float) {
        var arrTricks = DataManager._shared.lastTenTrick
        arrTricks.removeFirst()
        arrTricks.append(trick)
        DataManager._shared.lastTenTrick = arrTricks
        DataManager._shared.saveTrik(trick: trick, stab: stab, dif: dif)
    }
}


