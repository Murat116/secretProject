//
//  ChallengeDTO.swift
//  Wins
//
//  Created by Роман Шуркин on 05.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import RealmSwift

struct ChallengeDTO: Codable {
    var trick_name: String
    var boardShop: String
    var startDate: Int
    var endDate: Int?
    var sponsorImageData: Data?
    var descript: String?

    var promocode: String?
    var isDone: Bool?
    
    var isChallenge: Bool?
    var id: String?
}

extension ChallengeDTO: EntityProtocol {
    
    var entity: Object {
        
        let challenge = Challenge()
        
        challenge.trick_name = self.trick_name
        challenge.boardShop = self.boardShop
        challenge.startDate = self.startDate
        challenge.endDate = self.endDate
        challenge.sponsorImageData = self.sponsorImageData
        challenge.descript = self.descript
        challenge.promocode = self.promocode
        challenge.isDone = self.isDone ?? false
        challenge.isChallenge = self.isChallenge ?? true
        challenge.id = self.id
        
        return challenge
    }
}
