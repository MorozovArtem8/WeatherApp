//  Created by Artem Morozov on 20.07.2024.

import XCTest

final class WeatherAppUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        bundleForLocalizedTexts = Bundle(for: type(of: self))
    }
    
    func testShowMainScreenAfterSplash() {
        let sunButton = app.buttons["sunButton"]
        let rainButton = app.buttons["rainButton"]
        let cloudsButton = app.buttons["cloudsButton"]
        let snowButton = app.buttons["snowButton"]
        let imageView = app.images["imageView"]
        let weatherLabel = app.staticTexts["weatherLabel"]
        
        XCTAssertTrue(sunButton.waitForExistence(timeout: 5))
        XCTAssertTrue(rainButton.waitForExistence(timeout: 5))
        XCTAssertTrue(cloudsButton.waitForExistence(timeout: 5))
        XCTAssertTrue(snowButton.waitForExistence(timeout: 5))
        XCTAssertTrue(imageView.waitForExistence(timeout: 5))
        XCTAssertTrue(weatherLabel.waitForExistence(timeout: 5))
    }
    
    func testChangeLabelText() {
        let sunButton = app.buttons["sunButton"]
        let rainButton = app.buttons["rainButton"]
        let cloudsButton = app.buttons["cloudsButton"]
        let snowButton = app.buttons["snowButton"]
        XCTAssertTrue(sunButton.waitForExistence(timeout: 5))
        XCTAssertTrue(rainButton.waitForExistence(timeout: 5))
        XCTAssertTrue(cloudsButton.waitForExistence(timeout: 5))
        XCTAssertTrue(snowButton.waitForExistence(timeout: 5))
        
        sunButton.tap()
        
        let weatherLabel = app.staticTexts["weatherLabel"]
        XCTAssertTrue(weatherLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(weatherLabel.label, "sunny".localized, "Label text does not match localized string")
        
        rainButton.tap()
        XCTAssertEqual(weatherLabel.label, "rain".localized, "Label text does not match localized string")
        
        cloudsButton.tap()
        XCTAssertEqual(weatherLabel.label, "cloudy".localized, "Label text does not match localized string")
        
    }
}
