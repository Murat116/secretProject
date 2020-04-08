//
//  UserInfoRegRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 08.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class UserInfoRegRouter: UserInfoRegRouterProtocol{

    weak var viewController: UserInfoRegistrationVC!
    
    init(viewController: UserInfoRegistrationVC) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        self.viewController.dismiss(animated: true, completion: nil)
    }
    
    func openNextStep() {
        let nextStepVC = TricksRegVC()
        self.viewController.present(nextStepVC, animated: true, completion: self.closeCurrentViewController)
      }
    
    func openPhotoPicker() {
        //
    }
    
    
}
