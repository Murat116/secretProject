//
//  GameViewProtocol.swift
//  Wins
//
//  Created by Мурат Камалов on 04.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

protocol GameViewViewInput: class{
    func configure(with tenTricks: [Trick],_ actualChallenges: [Challenge])
    func openInfo()
}

protocol GameViewViewOutput: class{
    func saveChanges(of trick: Trick, with dif: Float, and stab: Int)
    func isChallengeDone(_ challenge: Challenge, done: Bool)
    func recountTechnocalSkill()
    func infoTapped()
    func speekTrick(trick: String!, speechState: Bool)
}

protocol GameViewInteractorOutput: class{
    func configure(with tenTricks: [Trick],_ actualChallenges: [Challenge])
}

protocol GameViewInteractorInput: class{
    func saveChanges(of trick: Trick, with dif: Float, and stab: Int)
    func isChallengeDone(_ challenge: Challenge, done: Bool)
    func recountTechnocalSkill()
}

protocol GameViewRouterInput: class {
    func showSpeechInfo()
}
