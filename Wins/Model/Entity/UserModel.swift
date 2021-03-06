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
class User: Object, Codable {
    
    dynamic var login: String? = nil
    dynamic var password: String? = nil
    dynamic var id: String = UUID().uuidString
    
    dynamic var name: String = "Guest"
    dynamic var city: String? = nil
    dynamic var age: Int = 0
    
    dynamic var facebook: String = ""
    dynamic var instagram: String = ""
    dynamic var vkontakte: String = ""
    
    dynamic var skateTrick = List<Trick>()
    dynamic var scootTrick = List<Trick>()
    dynamic var bmxTrick = List<Trick>()
    
    dynamic var challenges = List<Challenge>()
    
    dynamic var avatarImageData: Data? = nil
    
    dynamic var standIsRegular: Bool = true
    
    dynamic var totalStats: TotalStats? = TotalStats()
    dynamic var doneChallenges = List<Challenge>()
}

@objcMembers
class TotalStats: Object, Codable {
    
    dynamic var id: String = UUID().uuidString
    
    dynamic var technicality: Float = 0
    dynamic var stability: Float = 0
    dynamic var percentageTricksLearned: Float = 0
}

@objcMembers
class Challenge: Object, Codable {
    
    dynamic var trick_name: String = ""
    dynamic var boardShop: String = "Without sponsor("
    dynamic var startDate: Int = Int(Date.now.ts)
    dynamic var endDate: Int?
    dynamic var sponsorImageData: Data? = nil
    dynamic var descript: String? = ""

    dynamic var promocode: String? = nil
    dynamic var isDone: Bool = false
    
    dynamic var isChallenge: Bool = true
    dynamic var id: String?
    
    var trick: Trick?
    
    enum CodingKeys: String, CodingKey {
         case trick_name
         case boardShop
         case startDate
         case endDate
         case sponsorImageData
         case descript
         case promocode
         case isDone = "done"
         case isChallenge = "challenge"
         case id
    }
}

extension User: DTOProtocol {
    var dto: Any {
        
        var user = UserDTO()
        
        user.login = self.login
        user.password = self.password
        user.id = self.id
        user.name = self.name
        user.city = self.city
        user.age = self.age
        user.facebook = self.facebook
        user.instagram = self.instagram
        user.vkontakte = self.vkontakte
        user.skateTrick = self.convertTricksToDTO(self.skateTrick)
        user.scootTrick = self.convertTricksToDTO(self.scootTrick)
        user.bmxTrick = self.convertTricksToDTO(self.bmxTrick)
        user.challenges = self.convertChallengesToDTO(self.challenges)
        user.avatarImageData = self.avatarImageData
        user.standIsRegular = self.standIsRegular
        user.totalStats = self.totalStats?.dto as? TotalStatsDTO
        user.doneChallenges = self.convertChallengesToDTO(self.doneChallenges)
        
        return user
    }
    
    func convertTricksToDTO(_ tricks: List<Trick>) -> [TrickDTO] {
        
        var array = [TrickDTO]()
        
        tricks.forEach { array.append($0.dto as! TrickDTO) }
        
        return array
    }
    
    func convertChallengesToDTO(_ challenges: List<Challenge>) -> [ChallengeDTO] {
        
        var array = [ChallengeDTO]()
        
        challenges.forEach { array.append($0.dto as! ChallengeDTO) }
        
        return array
    }
}

extension TotalStats: DTOProtocol {
    
    var dto: Any {
        
        return TotalStatsDTO( id: self.id,
                               technicality: self.technicality,
                               stability: self.stability,
                               percentageTricksLearned: self.percentageTricksLearned)
    }
}

extension Challenge: DTOProtocol {
    
    var dto: Any {
        
        return ChallengeDTO( trick_name: self.trick_name,
                             boardShop: self.boardShop,
                             startDate: self.startDate,
                             isDone: self.isDone ,
                             isChallenge: self.isChallenge)
    }
}
