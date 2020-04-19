//
//  UserModel.swift
//  Wins
//
//  Created by Мурат Камалов on 16.04.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

@objcMembers
class User: NSObject{
    dynamic var login: String = ""
    dynamic var password: String = ""
    
    dynamic var name: String = ""
    dynamic var city: String = ""
    dynamic var age: Int = 0
    
    dynamic var facebook: String = ""
    dynamic var instagram: String = ""
    dynamic var vkonakte: String = ""
    
    dynamic var sport: Sports = Sports()
    dynamic var standIsRegular: Bool = true
    
    dynamic var totalStats: TotalStats = TotalStats()
    dynamic var promotionalСodes: [String] = []
    
}

struct Sports{
    var type: SportType = .skateboarding
    var tricks = [Trick]()
    
    enum SportType: Int{
        case skateboarding = 0
        case bmx = 1
        case scoot = 2
    }
}

struct TotalStats {
    var technicality: Float = 0
    var stability: Float = 0
    var percentageеTricksLearned: Float = 0
}
