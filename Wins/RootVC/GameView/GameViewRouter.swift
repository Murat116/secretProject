//
//  GameViewRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 06.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class GameViewRouter: GameViewRouterInput{
    weak var view: GameView!
    
    func showInfo() {
        let popover = UIViewController()
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: 300, height: 60)
        label.text = "Say Yes or No and controll\nthe game without pressing buttons"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = .white
        popover.view.addSubview(label)
        
        popover.modalPresentationStyle = .popover
        popover.preferredContentSize = CGSize(width: 300, height: 60)
        let popoverVC = popover.popoverPresentationController
        popoverVC?.delegate = self.view
        
        popoverVC?.sourceView = self.view.infoBtn
        popoverVC?.permittedArrowDirections = .up
        var frame = CGRect.zero
        frame.origin.x = self.view.infoBtn.frame.width / 2
        frame.origin.y = self.view.infoBtn.frame.height + 10
        popoverVC?.sourceRect = frame
        
        RootViewController._shared.present(popover, animated: true)
    }
}

