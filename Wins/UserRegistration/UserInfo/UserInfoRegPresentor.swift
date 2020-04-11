//
//  UserInfoRegPresentor.swift
//  Wins
//
//  Created by Мурат Камалов on 07.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//


class UserInfoRegPresentor: UserInfoRegPresenterProtocol{
    
    func nextBtnAction() {
        //открывать третий шаг
    }
    
    func openPhotoPicker() {
        //открывать фото пикер
    }
    
    
    weak var view: UserInfoRegViewProtocol!
    var router: UserInfoRegRouterProtocol!
    var interactor: UserInfoRegInteractorProtocol!
    
    func configureView() {
        self.view.setUp()
    }
    
    required init(view: UserInfoRegViewProtocol) {
        self.view = view
    }
}
