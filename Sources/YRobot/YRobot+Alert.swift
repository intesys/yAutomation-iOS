//
//  YRobot+Alert.swift
//
//  Created by Davide Benini on 21/10/24.
//

import XCTest

@MainActor
public extension YRobot {
    
    /// Asserts that an alert is present on screen
    /// - Parameter timeout: The timeout to wait for the element existence. Defaults: 5
    func assertHasAlert(timeout: TimeInterval = 5) {
        let loader = app.alerts.firstMatch
        XCTAssert(loader.waitForExistence(timeout: timeout))
    }
    
    /// Asserts that an alert with the provided text is present on screen
    /// - Parameter timeout: The timeout to wait for the element existence. Defaults: 5
    /// - Parameter wait: An optional delay after the assertion
    func assertsHasAlert(withText text: String, timeout: TimeInterval = 5, wait: TimeInterval?) {
        let loader = app.alerts
            .descendants(matching: .staticText)[text]
            .firstMatch
        
        XCTAssert(loader.waitForExistence(timeout: timeout))
        
        waitIfAny(wait)
    }
    
}
