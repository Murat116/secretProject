//
//  SignInRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 25.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import UIKit

class SignInRouter: SignInRouterInput{
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
    
}
