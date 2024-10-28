//
//  UITestHelper+Toggle.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func toggle(_ toggleIidentifier: String, wait: TimeInterval? = nil) {
        let actualSwitch = internalSwitch(switchIdentifier: toggleIidentifier)
        actualSwitch.tap()
        
        waitIfAny(wait)
    }
    
    func set(toggle toggleIidentifier: String, to value: Bool, wait: TimeInterval? = nil) {
        let actualSwitch = internalSwitch(switchIdentifier: toggleIidentifier)
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
