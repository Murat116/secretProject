//
//  RootVCInteractor.swift
//  Wins
//
//  Created by Мурат Камалов on 18.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

class RootVCInteractor{
    weak var output: RootInteractorOutput!
    
    var locationManager:LocationManager!
    
    var locationKey = ""
    
    func getUserData(){
        self.locationManager.setUp()
        let user = self.getUser()
        let challenges = self.getChallenges()
        let lastTricks = self.getTricks()
        self.output.configure(with: user, challenges, and: lastTricks)
    }
    
}
extension RootVCInteractor: RootInteractorInput{
    func recountTechnocalSkill() {
        let allTricks = self.getUser().skateTrick
        let doneTrick = allTricks.filter{$0.tries >= 1}
        var donesDif: Float = 0
        doneTrick.forEach{donesDif += $0.complexity}
        
        var allDif: Float = 0
        allTricks.forEach{allDif += $0.complexity}
        
        let techSkill = donesDif / allDif
        
        DataManager._shared.saveTechnikalSkill(techSkill)
    }
    
    func getUser() -> User {
        return DataManager._shared.getUser()!
    }
    
    func getChallenges() -> [Challenge]{
        let chalanges = DataManager._shared.getChalanges()
        return chalanges
    }
    
    func getTricks() -> [Trick] {
        let user = self.getUser()
        var lastTenTrick = DataManager._shared.lastTenTrick
        if lastTenTrick.isEmpty{
            let tricks = user.skateTrick 
            lastTenTrick = GameView.rundomTrick(tricks: Array(tricks))
            var lastTenTrickID = [String]()
            lastTenTrick.forEach { (trick) in
                lastTenTrickID.append(trick.name)
            }
            UserDefaults.standard.set(lastTenTrickID, forKey: USRDefKeys.lastTenTrick)
        }
        return lastTenTrick
    }
    
    func saveTrick(_ trick: Trick, with stab: Int, and dif: Float) {
        var arrTricks = DataManager._shared.lastTenTrick
        arrTricks.removeFirst()
        arrTricks.append(trick)
        DataManager._shared.lastTenTrick = arrTricks
        DataManager._shared.saveTrik(trick: trick, stab: stab, dif: dif)
    }
}

extension RootVCInteractor: LocationDelegate{
    func someError(error: Error?) {
        print(error)
    }
    
    func updateLocation(with region: String?) {
        if locationKey != region{
            self.locationKey = region ?? "Moscow"
            
            //читаем данные с сервера
        }
    }
}


