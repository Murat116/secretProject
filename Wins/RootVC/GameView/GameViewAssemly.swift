//
//  GameViewAssemly.swift
//  Wins
//
//  Created by Мурат Камалов on 04.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class GameViewAssembly{
    class func configureModule(with frame: CGRect) -> GameView{
        let view = GameView(frame: frame)
        
        let presentor = GameViewPresentor()
        let interactor = GameViewInteractor()
        let router = GameViewRouter()
        
        view.output = presentor
        interactor.output = presentor
        router.view = view
        
        presentor.view = view
        presentor.interactor = interactor
        presentor.router = router
        
        interactor.startConfigure()
        
        return view
    }
}
