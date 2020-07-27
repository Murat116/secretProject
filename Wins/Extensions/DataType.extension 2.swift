//
//  DataType.extension.swift
//  Wins
//
//  Created by Александр Сетров on 10.06.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
