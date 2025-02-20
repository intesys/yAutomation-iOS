//
//  YAutomation.swift
//
//  Created by Intesys on 21/10/24.
//
import XCTest
public struct YAutomationConfiguration {
    
    public static let defaultLoaderIdentifier = "loader"
    public static let defaultBackButtonIdentifier = "backButton"
    public static let defaultScrollingVelocity: XCUIGestureVelocity = 200
    
    var loaderIdentifier: String
    var backButtonIdentifier: String
    var scrollingVelocity: XCUIGestureVelocity

    public static var defaultConfiguration: YAutomationConfiguration {
        YAutomationConfiguration(loaderIdentifier: YAutomationConfiguration.defaultLoaderIdentifier,
                            backButtonIdentifier: YAutomationConfiguration.defaultBackButtonIdentifier ,
                            scrollingVelocity: YAutomationConfiguration.defaultScrollingVelocity)
    }
}


public class YAutomation {
    public var app: XCUIApplication
    public var configuration: YAutomationConfiguration = .defaultConfiguration
    
    public init(app: XCUIApplication, configuration: YAutomationConfiguration = .defaultConfiguration) {
        self.app = app
        self.configuration = configuration
    }
}

@MainActor
public extension YAutomation {
    
    /// Launches YAutomation. Must alway be called in the setUpWithError method of XCTestCase
    /// - Parameter arguments: an optional array of arguments to be attached to the tests suite. The presence of these arguments can be check at runtime with isRunningWith(argument:), in order to check if the app is running in a specific suite of tests. Optional.
    func launch(arguments: [String] = []) {
        app.launchArguments.append("--yautomation")
        for arg in arguments {
            app.launchArguments.append("--\(arg)")
        }
        app.launch()
    }
    
    /// Asserts that an activity indicator is present on the screen
    func assertHasActivityIndicator() {
        let loader = app.activityIndicators[configuration.loaderIdentifier]
        XCTAssert(loader.waitForExistence(timeout: 1))
    }
    
    /// Asserts that the screen contains a give text
    /// - Parameters:
    ///   - text: The text to search
    ///   - exactMatch: Whether the text must match exactly a label
    func assertHas(text: String, exactMatch: Bool = false, timeout: TimeInterval = 0) {
        if exactMatch {
            assertMatchesExactly(text: text, timeout: timeout)
        } else {
            assertContains(text: text, timeout: timeout)
        }
    }
    
    private func assertContains(text: String, timeout: TimeInterval) {
        if timeout == 0 {
            let labels = app.staticTexts.allElementsBoundByIndex.map { $0.label.lowercased() }
            let allText = labels.joined(separator: " ")
            if allText.contains(text.lowercased()) {
                return // Text found, test succeeds
            }
        }
        
        let startTime = Date()
        while Date().timeIntervalSince(startTime) < timeout {
            let labels = app.staticTexts.allElementsBoundByIndex.map { $0.label.lowercased() }
            let allText = labels.joined(separator: " ")
            
            if allText.contains(text.lowercased()) {
                return // Text found, test succeeds
            }
            
            RunLoop.current.run(until: Date().addingTimeInterval(0.1)) // Small delay to avoid busy waiting
        }
        
        XCTFail("Text '\(text)' not found within \(timeout) seconds.")
    }

    private func assertMatchesExactly(text: String, timeout: TimeInterval) {
        if timeout == 0 {
            let labels = app.staticTexts.allElementsBoundByIndex.map { $0.label.lowercased() }
            if labels.contains(text.lowercased()) {
                return // Exact match found, test succeeds
            }
        }
        let startTime = Date()
        while Date().timeIntervalSince(startTime) < timeout {
            let labels = app.staticTexts.allElementsBoundByIndex.map { $0.label.lowercased() }
            
            if labels.contains(text.lowercased()) {
                return // Exact match found, test succeeds
            }
            
            RunLoop.current.run(until: Date().addingTimeInterval(0.1)) // Small delay to avoid busy waiting
        }
        
        XCTFail("Exact match for text '\(text)' not found within \(timeout) seconds.")
    }

    
    /// Pauses the interaction of a given time interval
    /// - Parameter interval: the interval, in seconds
    func wait(interval: TimeInterval) {
        waitIfAny(interval)
    }
    
    /// Pauses the interaction of a given optional time interval
    /// - Parameter interval: the interval, in seconds. Optional.
    func waitIfAny(_ interval: TimeInterval?) {
        if let interval {
            sleep(UInt32(interval))
        }
    }
    
    /// Navigates back to a previous screen in the navigation stack
    func navigateBack() {
        tap(button: configuration.backButtonIdentifier)
    }
    
    /// Takes a screenshots and stores it in the test report
    /// - Parameters:
    ///   - name: The name to assign to the screenshot
    ///   - testCase: The test case to associate to the screenshot. Since this method is usually invoked inside  a text case method, this arguments is usually passed as "self".
    func takeScreenshot(name: String, in testCase: XCTestCase) {
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        testCase.add(attachment)
    }
}
