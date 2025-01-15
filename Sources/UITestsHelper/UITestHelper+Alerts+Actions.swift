//
//  UITestHelper+Alerts+Actions.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    /// Asserts that an alert exists
    func assertAlertExists() {
        let alert = app.alerts.firstMatch
        XCTAssert(alert.waitForExistence(timeout: 1))
    }

    /// Asserts that an alert has buttons with the given titles
    /// - Parameter buttons: the title of the buttons
    func assertAlertHasButtons(_ buttons: [String]) {
        let alert = app.alerts.firstMatch
        XCTAssert(alert.waitForExistence(timeout: 1))
        
        for buttonText in buttons {
            let thisButton = alert.buttons[buttonText]
            XCTAssert(thisButton.exists, "Alert has no \"\(buttonText)\" button")
        }
    }
    
    /// Asserts that an action sheet exists
    func assertActionSheetExists() {
        let sheet = app.sheets.firstMatch
        XCTAssert(sheet.waitForExistence(timeout: 1))
    }
    
    /// Asserts that an action sheet has buttons with the given titles
    /// - Parameter buttons: the title of the buttons
    func assertActionSheetHasButtons(_ buttons: [String]) {
        let sheet = app.sheets.firstMatch
        XCTAssert(sheet.waitForExistence(timeout: 1))
        
        for buttonText in buttons {
            let thisButton = sheet.buttons[buttonText]
            XCTAssert(thisButton.exists, "Action Sheet has no \"\(buttonText)\" button")
        }
    }
}
