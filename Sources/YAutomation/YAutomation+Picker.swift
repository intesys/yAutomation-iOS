//
//  YAutomation+Picker.swift
//
//  Created by Intesys on 28/10/24.
//

import Foundation
import XCTest

@MainActor
public extension YAutomation {
    
    /// Select the give text in the specified list picker; optionally specify a delay after the action
    /// - Parameters:
    ///   - text: The text to select
    ///   - pickerIdentifier: The identifier of the list picker to use
    ///   - wait: Optional: a delay which will be applied after selection
    func pickInListPicker(text: String, in pickerIdentifier: String, wait: TimeInterval? = nil) {
        let pickerButton = app.buttons.matching(identifier: pickerIdentifier).firstMatch
        XCTAssert(pickerButton.exists)
        pickerButton.tap()
        
        let targetButton = app.buttons.matching(NSPredicate(format: "label = '\(text)'")).firstMatch
        targetButton.tap()
        
        waitIfAny(wait)
    }
    
    /// Select the give text in the specified wheel picker; optionally specify a delay after the action
    /// - Parameters:
    ///   - text: The text to select
    ///   - pickerIdentifier: The identifier of the wheel picker to use
    ///   - wait: Optional: a delay which will be applied after selection
    func pickInWheelPicker(text: String, in pickerIdentifier: String, wait: TimeInterval? = nil) {
        let picker = app.pickers.matching(identifier: pickerIdentifier).firstMatch
        XCTAssert(picker.exists)
        picker.tap()
        
        let wheel = picker.pickerWheels.allElementsBoundByIndex[0]
        wheel.adjust(toPickerWheelValue: text)
        
        waitIfAny(wait)
    }
}
