# YRobot

A simple library to make it easier to implemnt UI Tests.

The library implements a `YRobot` class that can be used to simplify the most common UI interactions.

## Usage

In the typical usage, `YRobot` is initialized in the `setUpWithError` method of the XCTestCase subclass.

    var bot: YRobot!

    @MainActor
    override func setUpWithError() throws {
        bot = YRobot(app: XCUIApplication())
        bot.launch()
        ...
    }

Then the helper is invoked one or more times in different test cases.  
See the following example:

    @MainActor
    func testNavigation() throws {
        bot.tap(button: "Form")
        bot.navigateBack()
    }
    
For more examples and details, see the demo project.

## Project configuration
In order to use some of the app helpers, some UI elements must be properly configured in the codebase to be tested.



### Back buttons

UITestsHelper provides a custom accessible back button that is preconfigured to be used in UI testing.

    import YRobotConfigurator
    
    struct MyView {
        var body: some View {
            InnerView()
                .withAccessibleBackButton(title: "Home")
        }
    }

Alternatively, a given element can be made accessible with this helper:

Back button:

        makeAccessible(.backButton )

Loader

        makeAccessible(.loader)
      
In case a specific accessibility identifier is needed for back buttons and sliders, `YRobot` can be configured to use different identifier when initialized.

## Demo Project

The project in the `Demo` folder showcases the usage of YRobot

### Configuration
See the Loader.swift and FormView.swift files fo an example of the minimal configuration required for loaders and back buttonds

## Usage

See the `DemoUITests` class for a sample of the usage of `YRobot` with most UI controls and layout elements
The `BDDTests` showcases the usage of YRobot in conjunction with XCTest_Gherkin to implement the steps of BDD design test case.
