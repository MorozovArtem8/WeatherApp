//  Created by Artem Morozov on 20.07.2024.

import UIKit
@testable import WeatherApp

final class SplashScreenViewPresenterSpy: SplashScreenViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var viewDidAppearCalled: Bool = false
    
    var view: SplashScreenViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func viewDidAppear() {
        viewDidAppearCalled = true
    }
    
    
    
}
