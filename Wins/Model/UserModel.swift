//
//  UserModel.swift
//  Wins
//
//  Created by Мурат Камалов on 16.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class User: Object{
    dynamic var login: String = ""
    dynamic var password: String = ""
    
    dynamic var name: String = ""
    dynamic var city: String = ""
    dynamic var age: Int = 0
    
    dynamic var facebook: String = ""
    dynamic var instagram: String = ""
    dynamic var vkonakte: String = ""
    
    dynamic var skateTrick = List<Trick>()
    dynamic var scootTrick = List<Trick>()
    dynamic var bmxTrick = List<Trick>()
    
    dynamic var avatarImageData: Data = Data()
    
    dynamic var standIsRegular: Bool = true
    
    dynamic var totalStats: TotalStats? = TotalStats()
    dynamic var promotionalСodes = List<Promocodes>()
    
    override var description: String{
        return "\(self.login),\(self.password),\(self.skateTrick.last?.name)"
    }
    
}

@objcMembers
class TotalStats: Object {
    dynamic var technicality: Float = 0
    dynamic var stability: Float = 0
    dynamic var percentageеTricksLearned: Float = 0
}

@objcMembers
class Promocodes: Object{
    dynamic var promocode: String = ""
    dynamic var trikName: Trick? = Trick()
    dynamic var boardshop: String = ""
    dynamic var startDate: Date = Date()
    dynamic var endDate: Date = Date()
}
