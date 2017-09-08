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

extension UIColor {
  public convenience init(RGB red: Int, green: Int, blue: Int, alpha: Int) {
    self.init(
      red: CGFloat(red) / 255,
      green: CGFloat(green) / 255,
      blue: CGFloat(blue) / 255,
      alpha: CGFloat(alpha) / 255
    )
  }

  public convenience init(hex: String) {
    var correctedString = hex.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
    if correctedString.characters.count == 6 {
      correctedString += "FF"
    }

    let scanner = Scanner(string: correctedString)

    var result: UInt32 = 0
    scanner.scanHexInt32(&result)

    self.init(
      red: CGFloat(result & 0xFF00_0000) / 255.0,
      green: CGFloat(result & 0x00FF_0000) / 255.0,
      blue: CGFloat(result & 0x0000_FF00) / 255.0,
      alpha: CGFloat(result & 0x0000_00FF) / 255.0
    )
  }
}

public func ==(lhs: UIColor, rhs: UIColor) -> Bool {
  var lhsRgba = (r: CGFloat(0), g: CGFloat(0), b: CGFloat(0), a: CGFloat(0))
  lhs.getRed(
    &lhsRgba.r,
    green: &lhsRgba.g,
    blue: &lhsRgba.b,
    alpha: &lhsRgba.a
  )

  var rhsRgba = (r: CGFloat(0), g: CGFloat(0), b: CGFloat(0), a: CGFloat(0))
  rhs.getRed(
    &rhsRgba.r,
    green: &rhsRgba.g,
    blue: &rhsRgba.b,
    alpha: &rhsRgba.a
  )

  return round(lhsRgba.r * 255) == round(rhsRgba.r * 255)
    && round(lhsRgba.g * 255) == round(rhsRgba.g * 255)
    && round(lhsRgba.b * 255) == round(rhsRgba.b * 255)
    && round(lhsRgba.a * 255) == round(rhsRgba.a * 255)
}
