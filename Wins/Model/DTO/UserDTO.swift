//
//  UserDTO.swift
//  Wins
//
//  Created by Роман Шуркин on 05.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import RealmSwift

struct UserDTO: Codable {
    
    var login: String? = nil
    var password: String? = nil
    var id: String = UUID().uuidString
    
    var name: String = "Guest"
    var city: String? = nil
    var age: Int = 0
    
    var facebook: String = ""
    var instagram: String = ""
    var vkontakte: String = ""
    
    var skateTrick = [TrickDTO]()
    var scootTrick = [TrickDTO]()
    var bmxTrick = [TrickDTO]()
    
    var challenges = [ChallengeDTO]()
    
    var avatarImageData: Data? = nil
    
    var standIsRegular: Bool = true
    
    var totalStats: TotalStatsDTO?
    var doneChallenges = [ChallengeDTO]()
}

extension UserDTO: EntityProtocol {
    
    var entity: Object {
        
        let user = User()
        
        user.login = self.login
        user.password = self.password
        user.id = self.id
         
        user.name = self.name
        user.city = self.city
        user.age = self.age
         
        user.facebook = self.facebook
        user.instagram = self.instagram
        user.vkontakte = self.vkontakte
         
        user.skateTrick = self.convertDTOToTricks(self.skateTrick)
        user.scootTrick = self.convertDTOToTricks(self.scootTrick)
        user.bmxTrick = self.convertDTOToTricks(self.bmxTrick)
         
        user.challenges = self.convertDTOToChallenges(self.challenges)
         
        user.avatarImageData = self.avatarImageData
         
        user.standIsRegular = self.standIsRegular
         
        user.totalStats = self.totalStats?.entity as? TotalStats
        user.doneChallenges = self.convertDTOToChallenges(self.challenges)
        
        return user
    }
    
    private func convertDTOToTricks(_ tricks: [TrickDTO]) -> List<Trick> {
        
        let array = List<Trick>()
        
        tricks.forEach { array.append($0.entity as! Trick) }
        
        return array
    }
    
    private func convertDTOToChallenges(_ challenges: [ChallengeDTO]) -> List<Challenge> {
        
        let array = List<Challenge>()
        
        challenges.forEach { array.append($0.entity as! Challenge) }
        
        return array
    }
}
