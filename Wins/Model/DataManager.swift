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
    func getUser() -> User? {
        let user = self.realm?.objects(User.self).first
        
        return user
    }
    
    
    fileprivate var realm: Realm? {
        do{
            return try Realm(configuration: .defaultConfiguration)
        }catch{
            print(error.localizedDescription, "error in realm")
            return nil
        }
    }
    
}

extension DataManager{
    func createUser(login: String, password: String, sportType: SportType) {
        let tricks = List<Trick>()
        for trick in sportType.tricks{
            tricks.append(trick)
        }
        
        let user = User()
        user.login = login
        user.password = password
        user.skateTrick = tricks
        do{
            guard let realm = self.realm else { return }
            try realm.write{
                realm.add(user)
            }
        }catch{
            print(error.localizedDescription, "error in createUser")
        }
    }
}
