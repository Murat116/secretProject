//
//  DataManager.swift
//  Wins
//
//  Created by Мурат Камалов on 17.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import  RealmSwift

protocol DataManagerProtocol{
    
    func createUser(login: String?, password: String?, sportType: SportType)
    func getUser() -> User?
}


class DataManager: DataManagerProtocol {
    
    static var _shared = DataManager()

    var chalenges = [Challenge]()
    var lastTenTrick: [Trick] {
        get {
            let user = self.getUser()
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
    
    
    private init() {
        
    }
    
    fileprivate var realm: Realm? {
        do {
            return try Realm(configuration: .defaultConfiguration)
        } catch {
            print(error.localizedDescription, "error in realm")
            return nil
        }
    }
    
    func getUser() -> User? {
        
        let user = self.realm?.objects(User.self).first
        
        if let usr = user {
            self.chalenges = Array(usr.challenges)
        }
        
        return user
    }
    
    func saveTrik(trick: Trick,stab: Int, dif: Float){
        do {
            guard let realm = self.realm else { return }
            let total = trick.tries + 1
            try realm.write {
                trick.tries = total
                trick.stability = stab
                trick.complexity = dif
            }
        } catch {
            print(error.localizedDescription, "error in create User's tricks")
        }
    }
    
    func createSkateTricks() {
        
        guard let realm = self.realm else { return }
        let tricks = List<Trick>()
        let user = self.getUser()
        for trick in SportType.skate.tricks {
            
            tricks.append(trick)
            do {
                try realm.write {
                    realm.add(trick)
                    user?.skateTrick.append(trick)
                }
            } catch {
                print(error.localizedDescription, "error in create User's tricks")
            }
        }
        
        let chalenge = Challenge()
        let image = UIImage(named: "Registration/Sports/Skate")
        let data = image?.pngData()
        do {
            try realm.write {
                realm.add(chalenge)
                chalenge.date = Date()
                chalenge.trick = tricks.first{$0.name == "360 flip"}
                chalenge.isChallenge = true
                chalenge.sponsorImageData = data
                user?.challenges.insert(chalenge, at: 0)
            }
        } catch {
            print(error.localizedDescription, "error in create User's tricks")
        }
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
        
        guard let realm = self.realm else { return }
        
        if let trick = tricks.first(where: {$0.name == "360 flip"}) {
            
            let chalenge = Challenge()
            do {
                try realm.write{
                    realm.add(chalenge)
                    chalenge.date = Date()
                    chalenge.trick =  trick
                    chalenge.isChallenge = true
                }
            } catch {
                print(error.localizedDescription, "error in create User's tricks")
            }
            chalenges.append(chalenge)
        }
        
        let turnamet = Challenge()
        do {
            try realm.write {
                realm.add(turnamet)
                turnamet.date = Date()
                turnamet.isChallenge = false
            }
        } catch {
            print(error.localizedDescription, "error in create User's tricks")
        }

        let challenges = List<Challenge>()
        challenges.append(turnamet)
        
        let user = User()
        user.login = login
        user.password = password
        user.skateTrick = tricks
        user.challenges = challenges
        
        do {
            guard let realm = self.realm else { return }
            try realm.write {
                realm.add(user)
            }
        } catch {
            print(error.localizedDescription, "error in createUser")
        }
    }
}

extension DataManager {
    
    func saveTechnikalSkill(_ skill: Float) {
        
        guard let realm = self.realm,
        let user = self.getUser() else { return }
        
        do {
            try realm.write {
                user.totalStats?.technicality = skill
            }
        } catch {
            print(error.localizedDescription, "error in saving User technicality")
        }
    }
    
    func saveName(_ name: String) {
        do {
            guard let realm = self.realm,
                let user = self.getUser() else { return }
            
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
                let user = self.getUser() else { return }
            
            try realm.write {
                user.age = age
            }
        } catch {
            print(error.localizedDescription, "error in saving User age")
        }
    }
    
    func saveCity(_ city: String) {
        do{
            guard let realm = self.realm,
                let user = self.getUser() else { return }
            
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
                let user = self.getUser() else { return }
            
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
                let user = self.getUser() else { return }
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
                let user = self.getUser() else { return }
            
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
}
