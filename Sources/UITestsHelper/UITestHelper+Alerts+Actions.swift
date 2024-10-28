//
//  UITestHelper+Alerts+Actions.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func checkAlertExists() {
        let alert = app.alerts.firstMatch
        XCTAssert(alert.waitForExistence(timeout: 1))
    }
    func checkAlertHasButtons(_ buttons: [String]) {
        let alert = app.alerts.firstMatch
        XCTAssert(alert.waitForExistence(timeout: 1))
        
        for buttonText in buttons {
            let thisButton = alert.buttons[buttonText]
            XCTAssert(thisButton.exists, "Alert has no \"\(buttonText)\" button")
        }
    }
    func checkActionSheetExists() {
        let sheet = app.sheets.firstMatch
        XCTAssert(sheet.waitForExistence(timeout: 1))
    }
    
    func checkActionSheetHasButtons(_ buttons: [String]) {
        let sheet = app.sheets.firstMatch
        XCTAssert(sheet.waitForExistence(timeout: 1))
        
        for buttonText in buttons {
            let thisButton = sheet.buttons[buttonText]
            XCTAssert(thisButton.exists, "Action Sheet has no \"\(buttonText)\" button")
        }
    }
}
