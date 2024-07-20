//  Created by Artem Morozov on 20.07.2024.

import Foundation
@testable import WeatherApp

final class MainViewControllerSpy: MainViewControllerProtocol {
    init(presenter: MainViewPresenterProtocol) {
        self.presenter = presenter
    }
    var updateUICalled: Bool = false
    
    var presenter: MainViewPresenterProtocol
    
    func updateUI(userSelected: WeatherApp.CurrentWeather) {
        updateUICalled = true
    }
    
    
}
