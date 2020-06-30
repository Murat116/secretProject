//
//  TotalStatsDTO.swift
//  Wins
//
//  Created by Роман Шуркин on 05.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import RealmSwift

struct TotalStatsDTO: Codable {
   var id: String
   
   var technicality: Float
   var stability: Float
   var percentageTricksLearned: Float
}

extension TotalStatsDTO: EntityProtocol {
    
    var entity: Object {
        
        let ts = TotalStats()
        
        ts.id = self.id
        ts.technicality = self.technicality
        ts.stability = self.stability
        ts.percentageTricksLearned = self.percentageTricksLearned
        
        return ts
    }
}
