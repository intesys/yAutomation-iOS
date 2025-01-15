//
//  UITestsHelper+Alert.swift
//  Sandboxer
//
//  Created by Davide Benini on 21/10/24.
//

import XCTest

@MainActor
public extension UITestsHelper {
    func assertHasAlert(timeout: TimeInterval = 5) {
        let loader = app.alerts.firstMatch
        XCTAssert(loader.waitForExistence(timeout: timeout))
    }
    func assertsHasAlert(withText text: String, timeout: TimeInterval = 5, wait: TimeInterval?) {
        let loader = app.alerts
            .descendants(matching: .staticText)[text]
            .firstMatch
            
        XCTAssert(loader.waitForExistence(timeout: timeout))

        waitIfAny(wait)

    }
}
