//
//  UITestHelper+Picker.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//

import Foundation
import XCTest

@MainActor
public extension UITestsHelper {
    
    func pickInListPicker(text: String, in pickerIdentifier: String, wait: TimeInterval? = nil) {
        let pickerButton = app.buttons.matching(identifier: pickerIdentifier).firstMatch
        XCTAssert(pickerButton.exists)
        pickerButton.tap()
        
        let targetButton = app.buttons.matching(NSPredicate(format: "label = '\(text)'")).firstMatch
        targetButton.tap()
        
        waitIfAny(wait)
    }
    
    func pickInWheelPicker(text: String, in pickerIdentifier: String, wait: TimeInterval? = nil) {
        let picker = app.pickers.matching(identifier: pickerIdentifier).firstMatch
        XCTAssert(picker.exists)
        picker.tap()
        
        let wheel = picker.pickerWheels.allElementsBoundByIndex[0]
        wheel.adjust(toPickerWheelValue: text)
        
        waitIfAny(wait)
    }
}
