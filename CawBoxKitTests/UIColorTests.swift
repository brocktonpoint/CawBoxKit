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

import UIKit
import XCTest
@testable import CawBoxKit

class UIColorTests: XCTestCase {
  func testHexRed() {
    let red = UIColor.red
    let redHex = UIColor(hex: "#FF0000")

    XCTAssert(red == redHex, "Failed to create Red from #FF0000")
  }

  func testHexGreen() {
    let green = UIColor.green
    let greenHex = UIColor(hex: "#00FF00")

    XCTAssert(green == greenHex, "Pass")
  }

  func testHexBlue() {
    let blue = UIColor.blue
    let blueHex = UIColor(hex: "#0000FF")

    XCTAssert(blue == blueHex, "Pass")
  }

  func testHexAlpha() {
    let alpha = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    let alphaHex = UIColor(hex: "#00000080")

    XCTAssert(alpha == alphaHex, "Pass")
  }
}
