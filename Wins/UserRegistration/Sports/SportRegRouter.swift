//
//  SportRegRouter.swift
//  Wins
//
//  Created by Мурат Камалов on 11.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

class SportRegRouter: SportRegRouterProtocol{
    weak var view: SportsRegVC!
    
    func nextView() {
        if self.view.isRegistration{
            UserInfoRegistrationVC.show(parent: view, firstView: self)
        }else{
            self.view.dismiss(animated: true, completion: view.complition)
        }
    }
    
    func endRegistration(){
        self.view.complition!()
    }
    
    required init(vc: SportsRegVC) {
        self.view = vc
    }
    
    
}
