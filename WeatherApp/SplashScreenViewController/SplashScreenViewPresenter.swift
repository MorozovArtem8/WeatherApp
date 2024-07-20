//  Created by Artem Morozov on 20.07.2024.

import UIKit

protocol SplashScreenViewPresenterProtocol: AnyObject {
    var view: SplashScreenViewControllerProtocol? {get set}
    
    func viewDidLoad()
    func viewDidAppear()
}

final class SplashScreenViewPresenter: SplashScreenViewPresenterProtocol {
    
    weak var view: SplashScreenViewControllerProtocol?
    
    private let allWeatherCases = CurrentWeather.allCases
    
    private var timer: Timer?
    private var currentElementInArray: Int = 0
    private var randomCount = 0
    private var randomCountChecker = 0
    
    func viewDidLoad() {
        // Сейчас данный метод пуст, но по мере роста проекта возможно будет нужен
    }
    
    func viewDidAppear() {
        startAnimationCycle()
    }
    
    private func randomNumberInRange() -> Int {
        return Int.random(in: 4...7)
    }
    
    private func startAnimationCycle() {
        randomCount = randomNumberInRange()
        timer = Timer.scheduledTimer(timeInterval: 0.32, target: self, selector: #selector(timerStepAnimationFlow), userInfo: nil, repeats: true)
    }
    
    @objc private func timerStepAnimationFlow() {
        // В данной функции проходим по всем элементам allWeatherCases и говорим контроллеру какую ImageView и с какой анимацией нужно анимировать
        // Если выходим за пределы массива - обновляем currentElementInArray на 0 что бы начинать анимацию с первого элемента
        // Когда доходим до рандомной картинки - стопаем таймер, опять показываем нужную анимацию и с помощью DispatchQueue.main.asyncAfter переходим на MainViewController
        
        if currentElementInArray == allWeatherCases.count {
            currentElementInArray = 0
        }
        
        if randomCountChecker == randomCount {
            timer?.invalidate()
            timer = nil
            
            view?.animation(currentWeather: allWeatherCases[self.currentElementInArray], animationType: .scaleAnimation)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                self.presentMainViewController()
            }
            
            return
        }
        view?.animation(currentWeather: allWeatherCases[currentElementInArray], animationType: .liftingAnimation)
        currentElementInArray += 1
        randomCountChecker += 1
    }
    
    private func presentMainViewController() {
        let presenter = MainViewPresenter(currentWeatherState: allWeatherCases[currentElementInArray])
        let vc = MainViewController(presenter: presenter)
        presenter.view = vc
        vc.modalPresentationStyle = .fullScreen
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
           let window = windowSceneDelegate.window {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
}
