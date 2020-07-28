//
//  DoneChallengeRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 03.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class DoneChallengeRouter: DoneChallengeRouterInput {
    
    weak var view: UIViewController!
    
    func showPromocode(with promocode: String?) {
        guard let promocode = promocode else{
            let alert = UIAlertController(title: "It's challenge without promocode", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.view.present(alert, animated: true)
            return
        }
        let alert = UIAlertController(title: "Promocode:", message: promocode, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Coppy", style: .default, handler: { (_) in
            UIPasteboard.general.string = promocode
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.view.present(alert, animated: true)
    }
    
    func goBack() {
        self.view.navigationController?.popViewController(animated: true)
        self.view.dismiss(animated: true)
    }
}

