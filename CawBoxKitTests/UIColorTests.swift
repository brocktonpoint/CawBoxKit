//
//  UIColorTests.swift
//  CawBoxKit
//
//  Created by Aethus Northcott on 2015-07-24.
//  Copyright (c) 2015 CawBox. All rights reserved.
//

import UIKit
import XCTest

class UIColorTests: XCTestCase {
    func testHexRed () {
        let red = UIColor.redColor ()
        let redHex = UIColor (hex: "#FF0000")
        
        XCTAssert (red == redHex, "Failed to create Red from #FF0000")
    }
    func testHexGreen () {
        let green = UIColor.greenColor ()
        let greenHex = UIColor (hex: "#00FF00")
        
        XCTAssert (green == greenHex, "Pass")
    }
    func testHexBlue () {
        let blue = UIColor.blueColor ()
        let blueHex = UIColor (hex: "#0000FF")
        
        XCTAssert (blue == blueHex, "Pass")
    }
    func testHexAlpha () {
        let alpha = UIColor (red: 0, green: 0, blue: 0, alpha: 0.5)
        let alphaHex = UIColor (hex: "#00000080")
        
        XCTAssert (alpha == alphaHex, "Pass")
    }
}
