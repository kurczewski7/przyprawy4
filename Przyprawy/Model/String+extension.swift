//
//  String+extension.swift
//  Przyprawy
//
//  Created by Slawek Kurczewski on 05/04/2019.
//  Copyright © 2019 Slawomir Kurczewski. All rights reserved.
//

import Foundation
import CommonCrypto

enum CryptoMethods {
    case sha1
    case sha256
    case sha512
    case md5
}
extension String {
    func sha1() -> String{
        
        return shaMd5prepare(method: .sha1)
    }
    func sha256() -> String{
        return shaMd5prepare(method: .sha256)
    }
    func sha512() -> String{
        return shaMd5prepare(method: .sha256)
    }
    func md5() -> String{
        return shaMd5prepare(method: .md5)
    }
    private func shaMd5prepare(method: CryptoMethods) -> String    {
        var bufLen: Int32 = 0
        var ccCryptFunc = CC_SHA1
        // Check crypto method
        switch method {
        case .sha1:
            bufLen = CC_SHA1_DIGEST_LENGTH
            ccCryptFunc = CC_SHA1
        case .sha256:
            bufLen = CC_SHA256_DIGEST_LENGTH
            ccCryptFunc = CC_SHA256
        case .sha512:
            bufLen = CC_SHA512_DIGEST_LENGTH
            ccCryptFunc = CC_SHA512
        case .md5:
            bufLen = CC_MD5_DIGEST_LENGTH
            ccCryptFunc = CC_MD5
        }
        //prepare buffor
        var digitBuffor = [UInt8](repeating: 0, count: Int(bufLen))
        let data=Data(self.utf8)
        data.withUnsafeBytes {
            // f.e. CC_SHA1(data: len: md:) - genetate code using CommonCrypto
            _ =  ccCryptFunc($0.baseAddress, CC_LONG(data.count), &digitBuffor)
        }
        // convert output to hexadecimal (0..F)
        let hexBytes = digitBuffor.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}

