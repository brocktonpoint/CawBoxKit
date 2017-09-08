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
      red: CGFloat(min(max(red, 255), 0)) / 255,
      green: CGFloat(min(max(green, 255), 0)) / 255,
      blue: CGFloat(min(max(blue, 255), 0)) / 255,
      alpha: CGFloat(min(max(alpha, 255), 0)) / 255
    )
  }

  public enum HexError: Error {
    // .invalidLength (expects, currentLength)
    case invalidLength(Int, Int)
  }

  public enum HexType: String {
    case rgb
    case rgba
    case argb

    var expectedLength: Int {
      switch self {
      case .rgb: return 3
      case .rgba: return 4
      case .argb: return 4
      }
    }
  }

  public convenience init(hex: String, type: HexType = .rgb) throws {
    let correctedString = hex.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
      .uppercased()

    let values = UIColor.extractHexValues(from: correctedString)
    guard values.count == type.expectedLength else {
      throw HexError.invalidLength(
        type.expectedLength,
        values.count
      )
    }

    let r: CGFloat
    let g: CGFloat
    let b: CGFloat
    let a: CGFloat

    switch type {
    case .rgb:
      r = values[0]
      g = values[1]
      b = values[2]
      a = 255
    case .rgba:
      r = values[0]
      g = values[1]
      b = values[2]
      a = values[3]
    case .argb:
      a = values[0]
      r = values[1]
      g = values[2]
      b = values[3]
    }

    self.init(
      red: r / 255.0,
      green: g / 255.0,
      blue: b / 255.0,
      alpha: a / 255.0
    )
  }
}

fileprivate extension UIColor {
  static func extractHexValues(from: String) -> [CGFloat] {
    var currentIndex: String.Index? = from.startIndex

    var values: [CGFloat] = []
    while currentIndex != nil {
      guard let index = currentIndex,
        let nextIndex = from.index(index, offsetBy: 2, limitedBy: from.endIndex) else {
        break
      }

      var hexMultiple = 16
      values.append(from[index ..< nextIndex]
        .unicodeScalars.reduce(0) { result, scalar in
          defer {
            hexMultiple = 1
          }

          let intScalar = Int(scalar.value)
          var value = 0
          switch scalar.value {
          case 48 ... 57:
            value = (intScalar - 48)
          case 65 ... 70:
            value = (intScalar - 65) + 10
          default:
            break
          }

          return result + CGFloat(value * hexMultiple)
      })

      currentIndex = nextIndex
    }

    return values
  }
}

public func == (lhs: UIColor, rhs: UIColor) -> Bool {
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
