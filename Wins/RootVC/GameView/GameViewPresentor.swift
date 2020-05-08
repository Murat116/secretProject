//
//  GameViewPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 04.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import AVFoundation

class GameViewPresentor{
    weak var view: GameViewViewInput!
    var interactor: GameViewInteractorInput!
    var router: GameViewRouterInput!
    
}

extension GameViewPresentor: GameViewInteractorOutput{
    func configure(with tenTricks: [Trick], _ actualChallenges: [Challenge]) {
        self.view.configure(with: tenTricks, actualChallenges)
    }
}

extension GameViewPresentor: GameViewViewOutput{
    func speekTrick() {
        self.view.speekTrick()
    }
    
    func infoTapped() {
        self.router.showInfo()
    }
    
    func recountTechnocalSkill() {
        self.interactor.recountTechnocalSkill()
    }
    
    func saveChanges(of trick: Trick, with dif: Float, and stab: Int) {
        self.interactor.saveChanges(of: trick, with: dif, and: stab)
    }
    
    func isChallengeDone(_ challenge: Challenge, done: Bool) {
        self.interactor.isChallengeDone(challenge, done: true)
    }
}
