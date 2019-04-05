//
//  String+extension.swift
//  Przyprawy3
//
//  Created by Slawek Kurczewski on 05/04/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import CommonCrypto
extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            // Main sha1 process
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
