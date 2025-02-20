//
//  YAutomation+Tabs.swift
//
//  Created by Intesys on 15/01/25.
//
import XCTest

@MainActor
public extension YAutomation {
    
    /// Asserts that a tab bar exists
    /// - Parameter timeout: The timeout to wait for the element existence. Defaults: 0
    func assertTabBarExists(timeout: TimeInterval = 0) {
        let tabBar = app.tabBars.firstMatch
        XCTAssert(tabBar.waitForExistence(timeout: timeout))
    }
    
    /// Asserts that the app tab bar has count elements
    /// - Parameter count: The number of tabs to check against
    func assertTabBarHasTabs(count: Int) {
        let tabBar = app.tabBars.firstMatch
        XCTAssert(tabBar.exists)
        let tabs = tabBar.buttons.allElementsBoundByIndex
        XCTAssert(tabs.count == count)
    }
    
    /// Selects a tab at the given index
    /// - Parameters:
    ///   - index: The index of the tab to be selected
    ///   - wait: An optional delay after the selection
    func selectTab(index: Int, wait: TimeInterval? = nil) {
        let tabBar = app.tabBars.firstMatch
        XCTAssert(tabBar.exists)
        let tabs = tabBar.buttons.allElementsBoundByIndex
        tabs[index].tap()
        waitIfAny(wait)
    }

}
