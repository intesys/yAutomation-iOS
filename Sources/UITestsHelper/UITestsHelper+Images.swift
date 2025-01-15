//
//  UITestsHelper+Images.swift
//  UITestsHelper
//
//  Created by Davide Benini on 15/01/25.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func assertHasImages(count: Int, allowMore: Bool = false) {
        let images = app.images.allElementsBoundByIndex
        
        let tabBarImages = app.tabBars.firstMatch.images.allElementsBoundByIndex
        let totalCount = images.count - tabBarImages.count
        if allowMore {
            XCTAssert(totalCount >= count)
        } else {
            XCTAssert(totalCount == count)
        }
    }
}
