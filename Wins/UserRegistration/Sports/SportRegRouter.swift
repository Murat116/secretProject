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
        let userInfoReg = UserInfoRegistrationVC()
        view.present(userInfoReg, animated: true)
    }
    
    required init(vc: SportsRegVC) {
        self.view = vc
    }
    
    
}
