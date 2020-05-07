//
//  RootVCRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import UIKit

class RootVCRouter{
    weak var view: RootViewController!
}

extension RootVCRouter: RootRouterInput{
    
    func showTechnicalPopover() {
        let popover = UIViewController()
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: 320, height: 90)
        label.text = "Чем больше сложных трюков вы умеете, тем выше ваша техничность. Лучшая техничность - 1.0"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textColor = .white
        popover.view.addSubview(label)
        
        popover.modalPresentationStyle = .popover
        popover.preferredContentSize = CGSize(width: 320, height: 90)
        let popoverVC = popover.popoverPresentationController
        popoverVC?.delegate = self.view
        
        popoverVC?.sourceView = self.view.headerView.technicalButton
        popoverVC?.permittedArrowDirections = .up
        var frame = CGRect.zero
        frame.origin.x = 5
        frame.origin.y = self.view.headerView.technicalButton.frame.height + 10
        popoverVC?.sourceRect = frame
        
        RootViewController._shared.present(popover, animated: true)
    }
    
    func showGameView() {
        let gameView = GameViewAssembly.configureModule(with: self.view.view.frame)
        self.view.view.addSubview(gameView)
        
    }
    
    
    
    func goToDoneChallenge() {
        DoneChallengeVC.show(parent: view)
    }
    
    func goToReg() {
        SportsRegVC.show(parent: RootViewController._shared)
    }
    
    func goToSettings() {
        UserInfoRegistrationVC.show(parent: self.view)
    }
}
