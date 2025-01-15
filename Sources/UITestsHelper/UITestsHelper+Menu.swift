//
//  UITestsHelper+Menu.swift
//  UITestsHelper
//
//  Created by Davide Benini on 15/01/25.
//

import XCTest

@MainActor
public extension UITestsHelper {
    func menu(title: String) -> XCUIElement {
        app.buttons[title].firstMatch
    }
    func select(item: String, inMenu menu: String) {
        select(path: [item], inMenu: menu)
    }
    
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
