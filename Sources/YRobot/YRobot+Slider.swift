//
//  YRobot+Slider.swift
//
//  Created by Davide Benini on 28/10/24.
//
import XCTest

@MainActor
public extension YRobot {
    
    /// Asserts that a slider with the provided identifier is present on screen
    /// - Parameters:
    ///   - sliderIdentifier: The slider identifier
    ///   -  timeout: The timeout to wait for the element existence. Defaults: 0
    func assertSliderExists(_ sliderIdentifier: String, timeout: TimeInterval = 0) {
        let slider = app.sliders.matching(identifier: sliderIdentifier).firstMatch
        XCTAssert(slider.waitForExistence(timeout: timeout))
    }
    
    /// Sets the slider with the provided identifier to the given value
    /// - Parameters:
    ///   - slider: the slider identifier
    ///   - value: the value to be set
    ///   - wait: Optional: a delay which will be applied after the slider has been set
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
