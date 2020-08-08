//
//  String.extension.swift
//  Wins
//
//  Created by Роман Шуркин on 08.08.2020.
//  Copyright © 2020 Hope To. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    var hashString: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
