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

struct UserData<V> {
  static func setDefaults(defaults: [String: AnyObject]) {
    for (key, value) in defaults {
      if UserData<AnyObject>.get(forKey: key) == nil {
        UserData<AnyObject>.set(forKey: key, value: value)
      }
    }
  }

  static func clear(keys: [String]) {
    for key in keys {
      set(forKey: key, value: nil)
    }
  }

  static func clearAll() {
    sync(values: [:])
  }

  static func get(forKey: String) -> V? {
    return userData[forKey] as? V
  }

  static func set(forKey: String, value: V?) {
    var localUserData = userData

    if let object = value {
      localUserData[forKey] = object as AnyObject
    } else {
      localUserData.removeValue(forKey: forKey)
    }

    sync(values: localUserData)
  }
}

extension UserData {
  fileprivate static var userDataURL: URL? {
    let userDataUrl = try? FileManager.default.url(
      for: .cachesDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: true
    )

    return userDataUrl?.appendingPathComponent("userDataDefaults")
  }

  fileprivate static var userData: [String: AnyObject] {
    if let url = userDataURL, let data = try? Data(contentsOf: url) {
      if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
        let userData = json as? [String: AnyObject] {
        return userData
      }
    }

    return [:]
  }

  fileprivate static func sync(values: [String: AnyObject]) {
    if let url = userDataURL,
      let data = try? JSONSerialization.data(
        withJSONObject: values,
        options: .prettyPrinted) {
      try? data.write(to: url)
    }
  }
}
