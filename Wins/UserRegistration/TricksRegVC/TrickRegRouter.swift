//
//  TrickRegRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 10.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import UIKit

class TrickRegRouter {
    weak var view: TricksRegVC!
}

extension TrickRegRouter: TrickRegRouterInput{
    func endRegistration() {
        let viewController = RootVCRegAssembly.configureModule()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        
        UIApplication.shared.windows.first?.rootViewController = navigationViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
}
