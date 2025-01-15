//
//  UITestsHelper+Images.swift
//  UITestsHelper
//
//  Created by Davide Benini on 15/01/25.
//
import XCTest

@MainActor
public extension UITestsHelper {
    
    /// Asserts that the specified number of images is present on screen
    /// - Parameters:
    ///   - count: The number of images gthat ,must be on screen
    ///   - allowMore: Specifies if more images can be present or if it must be an exact match
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
