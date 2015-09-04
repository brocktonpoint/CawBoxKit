/*
The MIT License (MIT)

Copyright (c) 2015 CawBox

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

struct UserData <V> {
    static func setDefaults (defaults: [String: AnyObject]) {
        for (key, value) in defaults {
            if UserData<AnyObject>.get (key) == nil {
                UserData<AnyObject>.set (key, value: value)
            }
        }
    }
    static func clear (keys: [String]) {
        for key in keys {
            set (key, value: nil)
        }
    }
    static func clearAll () {
        sync ([:])
    }
    
    static func get (forKey: String) -> V? {
        return userData[forKey] as? V
    }
    static func set (forKey: String, value: V?) {
        var localUserData = userData
        
        if let object = value.self {
            localUserData[forKey] = object as? AnyObject
        } else {
            localUserData.removeValueForKey (forKey)
        }
        
        sync (localUserData)
    }
}

extension UserData {
    private static var userDataURL: NSURL? {
        let URL = try? NSFileManager.defaultManager().URLForDirectory (
            .CachesDirectory,
            inDomain: .UserDomainMask,
            appropriateForURL: nil,
            create: true
        )
        
        return URL?.URLByAppendingPathComponent ("userDataDefaults")
    }
    
    private static var userData: [String: AnyObject] {
        if let url = userDataURL, let data = NSData(contentsOfURL: url) {
            if let json = try? NSJSONSerialization.JSONObjectWithData (data, options: .MutableContainers),
                userData = json as? [String: AnyObject]{
                    return userData
            }
        }
        
        return [:]
    }
    
    private static func sync (values: [String: AnyObject]) {
        if let url = userDataURL, let data = try? NSJSONSerialization.dataWithJSONObject (values, options: .PrettyPrinted) {
            data.writeToURL (url, atomically: true)
        }
    }
}
