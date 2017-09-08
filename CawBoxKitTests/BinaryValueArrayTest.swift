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

import XCTest
import CoreLocation
@testable import CawBoxKit

class BinaryValueArrayTest: XCTestCase {

  /*
   func testCoreLocationBinaryArray() {
   var input = [
   CLLocationCoordinate2D(latitude: 49.287, longitude: 123.12),
   CLLocationCoordinate2D(latitude: 49.3, longitude: 123.2),
   CLLocationCoordinate2D(latitude: 49.1, longitude: 123.0),
   ]

   let data = NSData(bytes: &input, length: input.count * MemoryLayout<CLLocationCoordinate2D>.size)

   let output = BinaryValueArray<CLLocationCoordinate2D>(data: data, zeroValue: kCLLocationCoordinate2DInvalid).results

   XCTAssert(input.count == output.count, "Input != Output Count")
   for (index, location) in input.enumerated() {
   XCTAssert(location.latitude == output[index].latitude &&
   location.longitude == output[index].longitude, "Input[\(index)] != Output[\(index)] Count")
   }
   }*/
}
