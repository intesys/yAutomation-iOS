# yAutomation

`yAutomation` is a simple library to make it easier to implement UI Tests.

The library implements a `YAutomation` class that can be used to simplify the most common UI interactions.

We developed `yAutomation` to make it simpler to write UI tests based on `XCTest_Gherkin`. For this reason, the demo project includes a `BDDTests` test suite that uses `yAutomation` and `XCTest_Gherkin` together.

## Usage

### Configuration

In the typical usage, `YAutomation` is initialized in the `setUpWithError` method of the XCTestCase subclass.

    import XCTest
    import yAutomation
    
    final class DemoUITests: XCTestCase {

        var bot: YAutomation!
        var bot: YAutomation!

        @MainActor
        override func setUpWithError() throws {
            bot = YAutomation(app: XCUIApplication())
            bot.launch()
            ...
        }
        ...
    }

### Checking if the app is running in a test target

Sometimes you might need to execute specific operations only in the test target.

`yAutomation` provides a method for checking if the app was launched with it:

    import yAutomationConfigurator
    ...
    let isTest = isRunningYAutomationTests()

See the Demo `HomeView.swift` file for a sample of this method usage.

### Adding extra launch arguments

Sometimes you might want to identify a specific set of tests, that is, a `XCTestCase` subclass, in order to force some behaviour. For example, you might want to automatically log in users in a set of tests.

YAutomation accepts a set of optional launch arguments:


    @MainActor
    override func setUpWithError() throws {
        bot = YAutomation(app: XCUIApplication())
        bot.launch(arguments: ["skipLogin", "colorizeUsers"])
        ...
    }
    
In the app source code you will be able to check for the said arguments:

    import yAutomationConfigurator
    ...
    let shouldSkipLogin = isRunningWith(argument: "skipLogin")

Using launch arguments or test-only business logics inevitably creates dependencies between your app codebase and the testing suite. This is not ideal, but it is sometimes necessary to force some flows or scenarios that otherwise could not be tested.

### Simulating user interaction

The helper can be invoked one or more times in different test cases.  
See the following example:

    @MainActor
    func testNavigation() throws {
        bot.tap(button: "Form")
        bot.navigateBack()
    }

The "Form" label refers to either the text of the button or its accessibility identifier.

More complex helpers are available for other interactions, like filling in form fields, selecting dates, selecting alert values etc.

For more examples and details, see the demo project.

### Checking for the existence of elements

The usual way to validate a test is to assert the existence of a given text or UI element.

`yAutomation` provides a set of helpers:

    bot.assertHasTabBar()
    bot.assertTabBarHasTabs(count: 3)
    bot.assertHasImages(count: 2, allowMore: false)
    bot.assertHasAlert()
    bot.assertHasAlert(withText: "Alert title")
    bot.assertStepperExists()
    bot.assertDatePickerExists()
    bot.assertActionSheetExists()
    bot.assertActionSheetHasButtons(["1", "2", "3"])


## Project configuration
In order to use some of the app helpers, some UI elements must be properly configured in the codebase to be tested.


### Back buttons

`yAutomation` provides a custom accessible back button that is preconfigured to be used in UI testing.

    import yAutomationConfigurator
    
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
      
In case a specific accessibility identifier is needed for back buttons and sliders, `yAutomation` can be configured to use different identifier when initialized.

## Demo Project

The project in the `Demo` folder showcases the usage of `yAutomation`.

### Configuration
See the Loader.swift and FormView.swift files fo an example of the minimal configuration required for loaders and back buttons.

## Usage

See the `DemoUITests` class for a sample of the usage of `yAutomation` with most UI controls and layout elements.

The `BDDTests` showcases the usage of YAutomation in conjunction with XCTest_Gherkin to implement the steps of a BDD test suite.
