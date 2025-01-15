//
//  UITestHelper+Alerts+Actions.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    /// Check if an alert exists
    func checkAlertExists() {
        let alert = app.alerts.firstMatch
        XCTAssert(alert.waitForExistence(timeout: 1))
    }

    /// Check if an alert has buttons with the given titles
    /// - Parameter buttons: the title of the buttons
    func checkAlertHasButtons(_ buttons: [String]) {
        let alert = app.alerts.firstMatch
        XCTAssert(alert.waitForExistence(timeout: 1))
        
        for buttonText in buttons {
            let thisButton = alert.buttons[buttonText]
            XCTAssert(thisButton.exists, "Alert has no \"\(buttonText)\" button")
        }
    }
    
    /// Check if an action sheet exists
    func checkActionSheetExists() {
        let sheet = app.sheets.firstMatch
        XCTAssert(sheet.waitForExistence(timeout: 1))
    }
    
    /// Check if an action sheet has buttons with the given titles
    /// Check if an action sheet has buttons with the given titles
    /// - Parameter buttons: the title of the buttons
    func checkActionSheetHasButtons(_ buttons: [String]) {
        let sheet = app.sheets.firstMatch
        XCTAssert(sheet.waitForExistence(timeout: 1))
        
        for buttonText in buttons {
            let thisButton = sheet.buttons[buttonText]
            XCTAssert(thisButton.exists, "Action Sheet has no \"\(buttonText)\" button")
        }
    }
}
