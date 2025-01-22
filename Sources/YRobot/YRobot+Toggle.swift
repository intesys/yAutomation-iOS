//
//  YRobot+Toggle.swift
//
//  Created by Davide Benini on 28/10/24.
//
import XCTest

@MainActor
public extension YRobot {
    
    /// Asserts that a toggle with the provided identifier is present on screen
    /// - Parameters:
    ///   - toggleIdentifier: The date picker identifier
    ///   - timeout: The timeout to wait for the element existence. Defaults: 0
    func assertSwitchExists(_ toggleIdentifier: String, timeout: TimeInterval = 0) {
        let toggle = app.switches.matching(identifier: toggleIdentifier).firstMatch
        XCTAssert(toggle.waitForExistence(timeout: timeout))
    }
    
    /// Toggles on the toggle element with the provided identifier
    /// - Parameters:
    ///   - toggleIidentifier: The toggle identifier
    ///   - wait: Optional: a delay which will be applied after the toggling
    func toggle(_ toggleIidentifier: String, wait: TimeInterval? = nil) {
        let actualSwitch = internalSwitch(switchIdentifier: toggleIidentifier)
        actualSwitch.tap()
        
        waitIfAny(wait)
    }
    
    /// Set the toggle with the given identifer to the provided value
    /// - Parameters:
    ///   - toggleIidentifier: The toggle identifier
    ///   - value: The boolean value to apply to the toggle
    ///   - wait: Optional: a delay which will be applied after the toggling
    func set(switch switchIdentifier: String, to value: Bool, wait: TimeInterval? = nil) {
        let actualSwitch = internalSwitch(switchIdentifier: switchIdentifier)
        guard let stringValue = actualSwitch.value as? String, let intValue = Int(stringValue) else {
            XCTFail("Cannot egt switch value")
            return
        }
        if (intValue == 0 && value == true) || (intValue == 1 && value == false){
            actualSwitch.tap()
        }
    }
    
    private func internalSwitch(switchIdentifier: String) -> XCUIElement {
        let toggleElement = app.switches[switchIdentifier]
        XCTAssert(toggleElement.exists)
        
        let actualSwitch = toggleElement.switches.allElementsBoundByIndex[0]
        XCTAssert(actualSwitch.exists)
        return actualSwitch
    }
}
