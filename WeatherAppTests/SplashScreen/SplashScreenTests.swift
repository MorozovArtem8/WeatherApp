//  Created by Artem Morozov on 20.07.2024.

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        //given
        let SplashScreenPresenter = SplashScreenViewPresenterSpy()
        let SplashScreenVC = SplashScreenViewController(presenter: SplashScreenPresenter)
        SplashScreenPresenter.view = SplashScreenVC
        
        //when
        XCTAssertFalse(SplashScreenPresenter.viewDidLoadCalled)
        _ = SplashScreenVC.view
        
        //then
        XCTAssertTrue(SplashScreenPresenter.viewDidLoadCalled)
    }
}
