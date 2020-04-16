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
    
    dynamic var skateTrick: [Trick] = []
    dynamic var scootTrick: [Trick] = []
    dynamic var bmxTrick: [Trick] = []
    
    dynamic var standIsRegular: Bool = true
    
    dynamic var totalStats: TotalStats = TotalStats()
    dynamic var promotionalСodes: [Promocodes] = []
    
}

struct TotalStats {
    var technicality: Float = 0
    var stability: Float = 0
    var percentageеTricksLearned: Float = 0
}

struct Promocodes{
    var promocode: String
    var trikName: Trick
    var boardshop: String
    var startDate: Date
    var endDate: Date
}
