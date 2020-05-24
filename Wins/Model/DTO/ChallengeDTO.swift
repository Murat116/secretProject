//
//  ChallengeDTO.swift
//  Wins
//
//  Created by Роман Шуркин on 05.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

struct ChallengeDTO: Codable {
    var trick_name: String
    var boardShop: String
    var startDate: Int
    var endDate: Int?
    var sponsorImageData: Data?
    var descript: String?

    var promocode: String?
    var isDone: Bool
    
    var isChallenge: Bool
    var id: String?
}
