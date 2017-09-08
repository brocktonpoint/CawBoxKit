/*
 The MIT License (MIT)

 Copyright (c) 2017 CawBox

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation
import Security

public enum KeychainRequest {
  case genericPassword
  case internetPassword
  case certificate

  fileprivate var classTypeName: CFString {
    switch self {
    case .genericPassword:
      return kSecClassGenericPassword
    case .internetPassword:
      return kSecClassInternetPassword
    case .certificate:
      return kSecClassCertificate
    }
  }
}

public struct KeychainTransaction {
  public let request: KeychainRequest
  public let service: String
  public let attribute: String

  public var data: Data? {
    fatalError("Unimplemented")

    let query: [NSString: AnyObject] = [
      kSecClass: request.classTypeName,
      kSecAttrService: service as NSString,
      kSecReturnData: kCFBooleanTrue,
      kSecMatchLimitOne: kCFBooleanTrue
    ]

    var output: AnyObject?
    SecItemCopyMatching(query as NSDictionary, &output)

    return nil
  }

  public func set(value: Data?) -> Bool {
    // Clear the old value
    _ = delete()

    if let data = value {
      let query: [NSString: AnyObject] = [
        kSecClass: request.classTypeName,
        kSecAttrService: service as NSString,
        kSecAttrAccount: attribute as NSString,
        kSecValueData: data as NSData
      ]

      return SecItemAdd(query as CFDictionary, nil) == noErr
    }

    return false
  }

  public func delete() -> Bool {
    let query: [NSString: AnyObject] = [
      kSecClass: request.classTypeName,
      kSecAttrService: service as NSString,
      kSecAttrAccount: attribute as NSString
    ]

    return SecItemDelete(query as CFDictionary) == noErr
  }
}
