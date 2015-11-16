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

import XCTest
@testable import CawBoxKit

class UserDataTests: XCTestCase {

    func testUserData () {
        let stringKey = "string"
        let stringValue = "Here is some test string."
        
        let intKey = "int"
        let intValue = 12345
        
        let doubleKey = "double"
        let doubleValue = 0.54321
        
        UserData<AnyObject>.clearAll ()
        XCTAssert (UserData<String>.get (stringKey) == nil, "String value should be blank. (\(UserData<String>.get (stringKey)))")
        XCTAssert (UserData<Int>.get (intKey) == nil, "Int value should be blank. (\(UserData<Int>.get (intKey)))")
        XCTAssert (UserData<Double>.get (doubleKey) == nil, "Double value should be blank. (\(UserData<Double>.get (doubleKey)))")
        
        UserData<AnyObject>.setDefaults ([
            stringKey: stringValue,
            intKey: intValue,
            doubleKey: doubleValue
            ]
        )
        
        XCTAssert (UserData<String>.get (stringKey) == stringValue, "String value incorrect.")
        XCTAssert (UserData<Int>.get (intKey) == intValue, "Int value incorrect.")
        XCTAssert (UserData<Double>.get (doubleKey) == doubleValue, "Double value incorrect.")
        
        UserData<AnyObject>.clear ([stringKey])
        XCTAssert (UserData<String>.get (stringKey) == nil, "String value should be blank.")
        
        UserData<AnyObject>.set (intKey, value: nil)
        XCTAssert (UserData<Int>.get (intKey) == nil, "Int value should be blank.")
    }

}
