//
//  SignInRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class SignInRouter: SignInRouterInput {
    
    func signIn() {
        
        let viewController = RootVCRegAssembly.configureModule()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        
        UIApplication.shared.windows.first?.rootViewController = navigationViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func nextVc() {
        SportsRegVC.show(parent: self.view)
    }
    
    weak var view: SignInVIewController!
    
    func showSignAlert(text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    var loader = UIView()
    
    func showLoader() {
        
        self.loader.frame = self.view.view.frame
        self.loader.backgroundColor = UIColor(hex: "FEBB18")
        
        self.view.view.addSubview(loader)
    }
    
    func closeLoader() {
        self.loader.removeFromSuperview()
    }
}
