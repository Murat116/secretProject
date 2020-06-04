//
//  TrickDTO.swift
//  Wins
//
//  Created by Роман Шуркин on 05.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import RealmSwift

struct TrickDTO: Codable {
    
   var id: String
   var name: String
   var complexity: Float
   var stability: Int
   var tries: Int
}

extension TrickDTO: EntityProtocol {
    
    var entity: Object {
        
        let trick = Trick()
        
        trick.id = self.id
        trick.name = self.name
        trick.complexity = self.complexity
        trick.stability = self.stability
        trick.tries = self.tries
        
        return trick
    }
}
