//
//  UITestsHelper+Tabs.swift
//  UITestsHelper
//
//  Created by Davide Benini on 15/01/25.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func checkHasTabBar(timeout: TimeInterval = 5) {
        let tabBar = app.tabBars.firstMatch
        XCTAssert(tabBar.exists)
    }
    func checkTabBarHasTabs(count: Int) {
        let tabBar = app.tabBars.firstMatch
        XCTAssert(tabBar.exists)
        let tabs = tabBar.buttons.allElementsBoundByIndex
        XCTAssert(tabs.count == count)
    }

    func selectTab(index: Int, wait: TimeInterval? = nil) {
        let tabBar = app.tabBars.firstMatch
        XCTAssert(tabBar.exists)
        let tabs = tabBar.buttons.allElementsBoundByIndex
        tabs[index].tap()
        waitIfAny(wait)
    }
}
