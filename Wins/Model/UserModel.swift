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
    dynamic var login: String? = nil
    dynamic var password: String? = nil
    dynamic var id: String = ""
    
    dynamic var name: String = "Guest"
    dynamic var city: String? = nil
    dynamic var age: Int = 0
    
    dynamic var facebook: String = ""
    dynamic var instagram: String = ""
    dynamic var vkonakte: String = ""
    
    dynamic var skateTrick = List<Trick>()
    dynamic var scootTrick = List<Trick>()
    dynamic var bmxTrick = List<Trick>()
    
    dynamic var chalenges = List<Chalenges>()
    
    dynamic var avatarImageData: Data? = nil
    
    dynamic var standIsRegular: Bool = true
    
    dynamic var totalStats: TotalStats? = TotalStats()
    dynamic var promotionalСodes = List<Promocodes>()
    
    dynamic var lastTenTrick = List<Trick>()
    
    override var description: String{
        return "\(self)"
//        return "\(self.login),\(self.password),\(self.skateTrick.last?.name)"
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
    dynamic var trickName: Trick? = Trick()
    dynamic var boardshop: String = ""
    dynamic var startDate: Date = Date()
    dynamic var endDate: Date = Date()
}

@objcMembers
class Chalenges: Object{
    dynamic var trick: Trick? = Trick()
    dynamic var boardShop: String = "Without sponsor("
    dynamic var date: Date = Date()
    dynamic var sponsorImageData: Data? = nil
    dynamic var isChalenge: Bool = true
}
