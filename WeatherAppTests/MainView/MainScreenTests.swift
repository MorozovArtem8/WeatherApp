//  Created by Artem Morozov on 20.07.2024.

import XCTest
@testable import WeatherApp

final class MainScreenTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        //given
        let mainPresenter = MainViewPresenterSpy()
        let mainViewController = MainViewController(presenter: mainPresenter)
        mainPresenter.view = mainViewController
        
        //when
        XCTAssertFalse(mainPresenter.viewDidLoadCalled)
        _ = mainViewController.view
        
        //then
        XCTAssertTrue(mainPresenter.viewDidLoadCalled)
    }
    
    func testViewPresenterCallsUpdateUI() {
        //given
        let mainPresenter = MainViewPresenter(currentWeatherState: .clouds)
        let mainViewController = MainViewControllerSpy(presenter: mainPresenter)
        mainPresenter.view = mainViewController
        
        //when
        mainPresenter.viewDidLoad()
        
        //then
        XCTAssertTrue(mainViewController.updateUICalled)
    }
    
    
}
