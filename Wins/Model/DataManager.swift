//
//  DataManager.swift
//  Wins
//
//  Created by Мурат Камалов on 17.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataManagerProtocol{
    
    func createUser(login: String?, password: String?, sportType: SportType)
}


class DataManager: DataManagerProtocol {
    
    static var _shared = DataManager()
    
    fileprivate var realm: Realm? {
        do {
            return try Realm(configuration: .defaultConfiguration)
        } catch {
            print(error.localizedDescription, "error in realm")
            return nil
        }
    }
    
    var user: User? {
        let user = self.realm?.objects(User.self).first
        return user
    }
    
    var skateTricks: [Trick] {
        guard let skateTricks = self.realm?.objects(Trick.self) else {
            return self.createSkateTricks()
        }
        return Array(skateTricks)
    }
    
    var allChallanges: [Challenge] {
        
        guard let chalanges = self.realm?.objects(Challenge.self) else { return []}
        let arrayOfChalenges = chalanges.filter{$0.isChallenge}.sorted{$0.startDate >  $1.startDate}
        let arrayOfTurnament = chalanges.filter{!$0.isChallenge}.sorted{$0.startDate > $1.startDate}
        let array = arrayOfChalenges + arrayOfTurnament
        return array
    }
    
    var actualChallenges: [Challenge] {
        return self.allChallanges.filter{!$0.isDone}
    }
    
    var doneChallenges: [Challenge] {
        return self.allChallanges.filter{$0.isDone}
    }
    
    var lastTenTrick: [Trick] {
        get {
            let user = self.user
            guard let tricksName = UserDefaults.standard.value(forKey: USRDefKeys.lastTenTrick) as? [String],
                let tricks = user?.skateTrick else{
                    return []
            }
            var tricksArr = [Trick]()
            for name in tricksName{
                let trick = tricks.first{$0.name == name}
                guard trick != nil else { continue }
                tricksArr.append(trick!)
            }
            self.lastTenTrick = tricksArr
            return tricksArr
        }
        set {
            var array = [String]()
            newValue.forEach { (trick) in
                array.append(trick.name)
            }
            UserDefaults.standard.set(array, forKey: USRDefKeys.lastTenTrick)
        }
    }
    
    
    private init() {}
    
    func saveTrick(trick: Trick,stab: Int, dif: Float) {
        do {
            guard let realm = self.realm else { return }
            let total = trick.tries + 1
            let stabSave = stab < 0 ? trick.stability : stab
            let difSave = dif < 0 ? trick.complexity : dif
            try realm.write {
                trick.tries = total
                trick.stability = stabSave
                trick.complexity = difSave
            }
        } catch {
            print(error.localizedDescription, "error in create User's tricks")
        }
    }
    
    func createSkateTricks() -> [Trick] {
        guard let realm = self.realm else { return []}
        let tricks = List<Trick>()
        let user = self.user
        for trick in SportType.skate.tricks {
            
            tricks.append(trick)
            do {
                try realm.write {
                    user?.skateTrick.append(trick)
                }
            } catch {
                print(error.localizedDescription, "error in create User's tricks")
            }
        }
            
        return Array(tricks)
    }
}

extension DataManager {
    
    func createUser(login: String?, password: String?, sportType: SportType) {
        
        let tricks = List<Trick>()
        for trick in sportType.tricks {
            tricks.append(trick)
            do {
                guard let realm = self.realm else { return }
                try realm.write {
                    realm.add(trick)
                }
            } catch {
                print(error.localizedDescription, "error in create User's tricks")
            }
        }
        
        let user = User()
        user.login = login
        user.password = password
        user.skateTrick = tricks
        
        do {
            guard let realm = self.realm else { return }
            try realm.write {
                realm.add(user)
            }
        } catch {
            print(error.localizedDescription, "error in createUser")
        }
        
    }
    
    func addDefaultChalenge() {
        
        let kickflipChalenge = Challenge()
        let trick = self.skateTricks.first{ $0.name == "KickFlip"}
        kickflipChalenge.trick = trick
        kickflipChalenge.boardShop = ""
        kickflipChalenge.startDate = Date()
        
        kickflipChalenge.descript = "It's welcome chalenge:)"
        kickflipChalenge.isChallenge = true
        
        let turnamentPreview = Challenge()
        turnamentPreview.startDate = Date()
        turnamentPreview.endDate = Date().addingDays(4)
        turnamentPreview.isChallenge = false
        
        guard let realm = self.realm else { return }
        do {
            try realm.write{
                realm.add(kickflipChalenge)
                realm.add(turnamentPreview)
                self.user?.challenges.append(kickflipChalenge)
                self.user?.challenges.append(turnamentPreview)
            }
        } catch {
            print(error.localizedDescription, "error in create default chalenge")
        }
        
        print("saving")
    }
}

extension DataManager {
    
    func saveTechnikalSkill(_ skill: Float) {
        
        guard let realm = self.realm,
            let user = self.user else { return }
        let skilToSave = round(skill / 0.01) * 0.01
        do {
            try realm.write {
                user.totalStats?.technicality = skilToSave
            }
        } catch {
            print(error.localizedDescription, "error in saving User technicality")
        }
    }
    
    func saveName(_ name: String) {
        do {
            guard let realm = self.realm,
                let user = self.user else { return }
            
            try realm.write {
                user.name = name
            }
        } catch {
            print(error.localizedDescription, "error in saving User name")
        }
    }
    
    func saveAge(_ age: Int) {
        do {
            guard let realm = self.realm,
                let user = self.user else { return }
            
            try realm.write {
                user.age = age
            }
        } catch {
            print(error.localizedDescription, "error in saving User age")
        }
    }
    
    func saveCity(_ city: String) {
        do {
            guard let realm = self.realm,
                let user = self.user else { return }
            
            try realm.write {
                user.city = city
            }
        } catch {
            print(error.localizedDescription, "error in saving User city")
        }
    }
    
    func saveStand(_ name: String){
        do {
            guard let realm = self.realm,
                let user = self.user else { return }
            
            try realm.write {
                user.name = name
            }
        } catch {
            print(error.localizedDescription, "error in saving User name")
        }
    }
    
    func saveStand(_ stand: Bool) {
        do {
            guard let realm = self.realm,
                let user = self.user else { return }
            try realm.write {
                user.standIsRegular = stand
            }
        } catch {
            print(error.localizedDescription, "error in saving User stand")
        }
    }
    
    func saveSocialNet(_ link: String, type: SocialNetWork) {
        do {
            guard let realm = self.realm,
                let user = self.user else { return }
            
            try realm.write {
                switch type {
                case .facebook:
                    user.facebook = link
                case .instagram:
                    user.instagram = link
                case .twiter:
                    user.vkontakte = link
                }
            }
        } catch {
            print(error.localizedDescription, "error in saving User soc network")
        }
    }
    
    func saveImage(_ image: UIImage) {
        guard let realm = self.realm,
            let user = self.user,
            let data = image.pngData() else { return }
        do {
            try realm.write {
                user.avatarImageData = data
            }
        } catch {
            print(error.localizedDescription, "error in saving User image")
        }
    }
    
    func saveChallenge(_ challenge: Challenge) {
        guard let realm = self.realm else { return }
        do {
            try realm.write{
                challenge.isDone = true
            }
        } catch {
            print(error.localizedDescription, "error in saving User image")
        }
    }
}
