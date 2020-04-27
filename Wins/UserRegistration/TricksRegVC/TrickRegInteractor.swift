//
//  TrickRegInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 10.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class TrickRegInteractor{
    weak var output: TricckRegInteractorOutput!
    
    func getUserData(){
        guard let trick = DataManager._shared.user?.skateTrick else { return }
        self.output.configure(with: Array(trick))
    }
    
}

extension TrickRegInteractor: TrickRegInteractorlInput{
    
    func saveUserData(with trick: Trick, _ newDif: Float, _ newStab: Int) {
        DataManager._shared.saveTrik(trick: trick, stab: newStab, dif: newDif)
    }

}
