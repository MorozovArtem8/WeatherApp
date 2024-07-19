//  Created by Artem Morozov on 20.07.2024.

import UIKit

protocol SplashScreenViewPresenterProtocol: AnyObject {
    var view: SplashScreenViewControllerProtocol? {get set}
    
    func startAnimationCycle()
}

final class SplashScreenViewPresenter: SplashScreenViewPresenterProtocol {
   
    var view: SplashScreenViewControllerProtocol?
    
    func startAnimationCycle() {
        
    }
    
}
