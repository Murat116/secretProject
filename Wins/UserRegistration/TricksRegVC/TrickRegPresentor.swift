//
//  TrickRegPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 10.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class TrickRegPresentor: TrickRegPresentorProtocol{
    
    var interactor: TrickRegInteractorProtocol!
    var router: TrickRegRouterProtocol!
    var view: TrickRegViewProtocol!
    
    func configureView() {
        self.view.setUpUI()
    }
    
    required init(view: TrickRegViewProtocol) {
        self.view = view
    }
    
}
