//
//  BDDTests.swift
//  Sandboxer
//
//  Created by Davide Benini on 30/10/24.
//

import XCTest
import XCTest_Gherkin
@testable import Demo
import YRobot

class BDDTests: XCTestCase {
    
    var inty: YRobot!
    
    @MainActor
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
       XCUIApplication().launch()
    }
    
    func test_controls() {
       
        NativeRunner.runScenario(featureFile: "gherkin.feature",
                                 scenario: "go to list",
                                 testCase: self)
    }
    
    func test_pippo() {
       
        NativeRunner.runScenario(featureFile: "gherkin.feature",
                                 scenario: "test Pippo",
                                 testCase: self)
    }
}



private final class StepsDefinition: StepDefiner {
    
    var inty: YRobot!

    required init(test: XCTestCase, regexOptions: NSRegularExpression.Options = [.caseInsensitive]) {
        let configuration = YRobotConfiguration.defaultConfiguration
        inty = YRobot(app: XCUIApplication(), configuration: configuration)

        super.init(test: test, regexOptions: regexOptions)
        
    }
    
    
        
    override func defineSteps() {
        MainActor.assumeIsolated {
            self.step("I tap '(.+)'") { (buttonName: String) in
                self.inty.tap(button: buttonName)
            }
            self.step("I see '(.+)'") { (text: String) in
                XCTAssert(self.inty.app.staticTexts[text].firstMatch.exists)
            }
            
            self.step("I am in the homepage") {
                
            }
            
            self.step("I use Pippo.increment") {
                Pippo.shared.increment()
            }
            self.step("Pippo.count is 1") {
                XCTAssert(Pippo.shared.count == 1)
            }
        }
    }
    // TODO: METTI esempio di Scenario outline
    // TODO: specifica come mettere env varibale ecc
}

class Pippo {
    static let shared = Pippo()
    var count: Int = 0
    func increment() {
        count += 1
    }
}
