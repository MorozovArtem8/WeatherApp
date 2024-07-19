//  Created by Artem Morozov on 20.07.2024.

import UIKit

protocol SplashScreenViewPresenterProtocol: AnyObject {
    var view: SplashScreenViewControllerProtocol? {get set}
    var images: [UIImageView] { get set }
    
    func viewDidLoad()
    func viewDidAppear()
}

final class SplashScreenViewPresenter: SplashScreenViewPresenterProtocol {
    
    weak var view: SplashScreenViewControllerProtocol?
    
    var images: [UIImageView] = []
    private var timer: Timer?
    private var currentImagesInArray: Int = 0
    private var randomCount = 0
    private var randomCountChecker = 0
    
    func viewDidLoad() {
        // Сейчас данный метод пуст, но по мере роста проекта возможно будет нужен
    }
    
    func viewDidAppear() {
        startAnimationCycle()
    }
    
    private func randomNumberInRange() -> Int {
        return Int.random(in: 5...10)
    }
    
    private func startAnimationCycle() {
        randomCount = randomNumberInRange()
        timer = Timer.scheduledTimer(timeInterval: 0.32, target: self, selector: #selector(animateNextImage), userInfo: nil, repeats: true)
    }
    
    @objc private func animateNextImage() {
        if currentImagesInArray == 4 {
            currentImagesInArray = 0
        }
        
        if randomCountChecker == randomCount {
            timer?.invalidate()
            timer = nil
            
            view?.scaleAnimation(imageView: self.images[self.currentImagesInArray])
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                let presenter = MainViewPresenter(currentWeatherState: self.currentWeather())
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
            
            return
        }
        
        view?.scrollAnimation(imageView: images[currentImagesInArray])
        currentImagesInArray += 1
        randomCountChecker += 1
    }
    
    private func currentWeather() -> CurrentWeather {
        if currentImagesInArray == 0 {
            return .sun
        } else if currentImagesInArray == 1 {
            return .rain
        } else if currentImagesInArray == 2 {
            return .clouds
        } else {
            return .snow
        }
    }
}
