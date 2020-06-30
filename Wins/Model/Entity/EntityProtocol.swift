//
//  EntityProtocol.swift
//  Wins
//
//  Created by Роман Шуркин on 24.05.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import RealmSwift

protocol EntityProtocol: Codable {
    var entity: Object { get }
}
