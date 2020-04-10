//
//  UsersTricksRegVC.swift
//  Wins
//
//  Created by Мурат Камалов on 09.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class TricksRegVC: Registration{
    
    var presenter: TrickRegPresentorProtocol!
    var configurator: TrickRegConfiguratorProtocol = TrickRegConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configurator.configure(with: self)
        self.presenter.configureView()
    }
}

extension TricksRegVC: TrickRegViewProtocol{
    func setUpUI() {
        self.stepsType = .tricks
        self.configure(step: self.stepsType)
    }
}
