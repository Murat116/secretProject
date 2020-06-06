//
//  DoneChallengePresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 03.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class DoneChallengePresentor{
    weak var view: DoneChallengeViewInput!
    var router: DoneChallengeRouterInput!
    
}

import UIKit
extension DoneChallengePresentor: DoneChallemgeViewOutput{
    
    func goBack() {
        self.router.goBack()
    }
    
    func showPromocode(with promocode: String?) {
        self.router.showPromocode(with: promocode)
    }
}

extension DoneChallengePresentor: DoneChallengeInteractorOutput{
    func configureView(with challenges: [Challenge]) {
        self.view.configureView(with: challenges)
    }
}
