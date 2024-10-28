//
//  UITestHelper+Slider.swift
//  Sandboxer
//
//  Created by Davide Benini on 28/10/24.
//
import XCTest

@MainActor
public extension UITestsHelper {
    func set(slider: String, to value: Double, wait: TimeInterval? = nil) {
        let slider = app.sliders.matching(identifier: slider).firstMatch
        XCTAssert(slider.exists)
        slider.adjust(toNormalizedSliderPosition: 1)
        guard let maxValueString = slider.value as? String, let maxValue = Double(maxValueString) else {
            XCTFail("Cannot get slider max value")
            return
        }
        let normalizedPosition = value / maxValue
        slider.adjust(toNormalizedSliderPosition: normalizedPosition)
        // Double set necessary because of dragging inertia
        slider.adjust(toNormalizedSliderPosition: normalizedPosition)
        waitIfAny(wait)


    }
}
