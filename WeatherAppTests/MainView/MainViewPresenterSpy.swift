//  Created by Artem Morozov on 20.07.2024.

import Foundation
@testable import WeatherApp

final class MainViewPresenterSpy: MainViewPresenterProtocol {

    var viewDidLoadCalled: Bool = false
    
    var view: MainViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func viewUpdateUI() {
        
    }
    
    func didTapSunButton() {
        
    }
    
    func didTapRainButton() {
        
    }
    
    func didTapCloudButton() {
        
    }
    
    func didTapSnowButton() {
        
    }
    
    
}
