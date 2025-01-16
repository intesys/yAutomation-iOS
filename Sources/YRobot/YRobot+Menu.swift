//
//  YRobot+Menu.swift
//
//  Created by Davide Benini on 15/01/25.
//

import XCTest

@MainActor
public extension YRobot {
    
    /// Returns a menu with the given title
    /// - Parameter title: the menu title
    /// - Returns:The menu XCUIElement
    func menu(title: String) -> XCUIElement {
        app.buttons[title].firstMatch
    }
    
    /// Selects the item with the given title from the specified menu
    /// - Parameters:
    ///   - item: The item to select
    ///   - menu: The menu of the item
    func select(item: String, inMenu menu: String) {
        select(path: [item], inMenu: menu)
    }
    
    ///   Selects the item at the end of the specified tree path from the specified menu
    /// - Parameters:
    ///   - path: A sequential list of the items to select
    ///   - menu: The menu of the item
    func select(path: [String], inMenu menu: String) {
        let menu = app.buttons[menu].firstMatch
        XCTAssert(menu.exists)
        menu.tap()
        
        for pathItem in path {
            let itemElement = app.buttons[pathItem]
            itemElement.tap()
        }

    }

}
