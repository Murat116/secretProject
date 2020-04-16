//
//  TotalStatsConfigurator.swift
//  Wins
//
//  Created by Роман Шуркин on 12.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import UIKit

class TotalStatsConfigurator {
    
    class func configure() -> UIViewController {
        
        let view = TotalStatsVC()
        
        let presenter = TotalStatsPresenter()
        
        view.output = presenter
        
        presenter.view = view
        presenter.dataManager = dataManager
        
        return view
    }
}
