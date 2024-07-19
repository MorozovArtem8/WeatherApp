//  Created by Artem Morozov on 19.07.2024.

import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    var view: MainViewControllerProtocol? {get set}
    
    func viewDidLoad()
    func didTapSunButton()
    func didTapRainButton()
    func didTapCloudButton()
    func didTapSnowButton()
    func viewUpdateUI()
}

final class MainViewPresenter: MainViewPresenterProtocol {
    
    init(currentWeatherState: CurrentWeather) {
        self.currentWeatherState = currentWeatherState
    }
    
    weak var view: MainViewControllerProtocol?
    
    private var currentWeatherState: CurrentWeather {
        didSet {
            viewUpdateUI()
        }
    }
    
    func viewDidLoad() {
        // Сейчас данный метод копия viewUpdateUI, но по мере роста проекта возможно будет нужен
        view?.updateUI(userSelected: currentWeatherState)
    }
    
    func didTapSunButton() {
        currentWeatherState = .sun
    }
    
    func didTapRainButton() {
        currentWeatherState = .rain
    }
    
    func didTapCloudButton() {
        currentWeatherState = .clouds
    }
    
    func didTapSnowButton() {
        currentWeatherState = .snow
    }
    
    func viewUpdateUI() {
        view?.updateUI(userSelected: currentWeatherState)
    }
    
    
}
