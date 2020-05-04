//
//  DoneChallengeRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 03.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class DoneChallengeRouter: DoneChallengeRouterInput{
    weak var view: UIViewController!
    
    func showPromocode(with alert: UIAlertController) {
        self.view.present(alert, animated: true)
    }
    
    func goBack() {
        self.view.navigationController?.popViewController(animated: true)
        self.view.dismiss(animated: true)
    }
}

