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
    func createUser(login: String, password: String, sportType: SportType)
    func getUser() -> User?
    
}


class DataManager: DataManagerProtocol{
    
    static var _shared = DataManager()
    
    var user: User? = nil
    var chalenges = [Chalenges]()
    
    private init(){
       
    }
    
    fileprivate var realm: Realm? {
        do{
            return try Realm(configuration: .defaultConfiguration)
        }catch{
            print(error.localizedDescription, "error in realm")
            return nil
        }
    }
    
    func getUser() -> User? {
        let user = self.realm?.objects(User.self).first
        self.user = user
        
        if let usr = user{
            self.chalenges = Array(usr.chalenges)
        }
        
        return user
    }
    
    func saveTrik(trick: Trick,stab: Int, dif: Float){
        do{
            guard let realm = self.realm else { return }
            try realm.write{
                trick.stabuluty = stab
                trick.difficults = dif
            }
        }catch{
            print(error.localizedDescription, "error in create User's tricks")
        }
    }
    
}

extension DataManager{
    func createUser(login: String, password: String, sportType: SportType) {
        let tricks = List<Trick>()
        for trick in sportType.tricks{
            tricks.append(trick)
            do{
                guard let realm = self.realm else { return }
                try realm.write{
                    realm.add(trick)
                }
            }catch{
                print(error.localizedDescription, "error in create User's tricks")
            }
        }
        
        guard let realm = self.realm else { return }
        let chalenge = Chalenges()
        try! realm.write{
            realm.add(chalenge)
        }
        
        let user = User()
        user.login = login
        user.password = password
        user.skateTrick = tricks
        do{
            guard let realm = self.realm else { return }
            try realm.write{
                realm.add(user)
                user.chalenges.append(chalenge)
            }
        }catch{
            print(error.localizedDescription, "error in createUser")
        }
    }
}

extension DataManager{
    
    func saveName(_ name: String){
        do{
            guard let realm = self.realm,
                let user = self.user else { return }
            
            try realm.write{
                user.name = name
            }
        }catch{
            print(error.localizedDescription, "error in saving User name")
        }
    }
    
    func saveAge(_ age: Int){
        do{
            guard let realm = self.realm ,
                let user = self.user else { return }
            
            try realm.write{
                user.age = age
            }
        }catch{
            print(error.localizedDescription, "error in saving User age")
        }
    }
    
    func saveCity(_ city: String){
        do{
            guard let realm = self.realm ,
                let user = self.user else { return }
            
            try realm.write{
                user.city = city
            }
        }catch{
            print(error.localizedDescription, "error in saving User city")
        }
    }
    
    func saveStand(_ name: String){
        do{
            guard let realm = self.realm ,
                let user = self.user else { return }
            
            try realm.write{
                user.name = name
            }
        }catch{
            print(error.localizedDescription, "error in saving User name")
        }
    }
    
    func saveStand(_ stand: Int){
        do{
            guard let realm = self.realm ,
                let user = self.user else { return }
            let isRegulat = stand == 0
            try realm.write{
                user.standIsRegular = isRegulat
            }
        }catch{
            print(error.localizedDescription, "error in saving User stand")
        }
    }
    
    func saveSocialNet(_ link: String, type: SocialNetWork){
        do{
            guard let realm = self.realm,
                let user = self.user else { return }
            
            try realm.write{
                switch type{
                case .facebook:
                    user.facebook = link
                case .instagram:
                    user.instagram = link
                case .twiter:
                    user.vkonakte = link
                }
            }
        }catch{
            print(error.localizedDescription, "error in saving User soc network")
        }
    }
    
}
