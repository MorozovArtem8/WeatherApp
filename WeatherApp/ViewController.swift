//
//  ViewController.swift
//  WeatherApp
//
//  Created by Artem Morozov on 17.07.2024.
//

import UIKit

enum CurrentWeather {
    case sun
    case rain
    case clouds
    case snow
}

class ViewController: UIViewController {
    @IBOutlet weak var sunButton: UIButton!
    @IBOutlet weak var rainButton: UIButton!
    @IBOutlet weak var cloudsButton: UIButton!
    @IBOutlet weak var snowButton: UIButton!
    
    private weak var mainWeatherImageView: UIImageView?
    private weak var snowflake: UIImageView?
    
    var buttons = [UIButton]()
    private var currentWeatherState: CurrentWeather = .sun {
        didSet {
            updateUI()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        buttons = [sunButton, rainButton, cloudsButton, snowButton]
        updateUI()
    }
    @IBAction func sunButtonDidTapped(_ sender: UIButton) {
        currentWeatherState = .sun
    }
    @IBAction func rainButtonDidTapped(_ sender: UIButton) {
        currentWeatherState = .rain
    }
    @IBAction func cloudsButtonDidTapped(_ sender: UIButton) {
        currentWeatherState = .clouds
    }
    @IBAction func snowButtonDidTapped(_ sender: UIButton) {
        currentWeatherState = .snow
    }
    
    
    
    private func updateUI() {
        mainWeatherImageView?.layer.removeAllAnimations()
        snowflake?.layer.removeAllAnimations()
        snowflake?.removeFromSuperview()
        resetSelectButtons()
        selectButton()
    }
    
    private func resetSelectButtons() {
        
        for button in buttons {
            button.backgroundColor = .clear
        }
    }
    
    private func selectButton() {
        switch currentWeatherState {
        case .sun:
            self.mainWeatherImageView?.image = UIImage(named: "sunBig")
            sunButton.layer.cornerRadius = 15
            sunButton.clipsToBounds = true
            sunButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
            sunAnimation()
            
        case .rain:
            self.mainWeatherImageView?.image = UIImage(named: "rainBig")
            rainButton.layer.cornerRadius = 15
            rainButton.clipsToBounds = true
            rainButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
            animateBackgroundRain()
        case .clouds:
            self.mainWeatherImageView?.image = UIImage(named: "cloudsBig")
            cloudsButton.layer.cornerRadius = 15
            cloudsButton.clipsToBounds = true
            cloudsButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
        case .snow:
            self.mainWeatherImageView?.image = UIImage(named: "snowBig")
            snowButton.layer.cornerRadius = 15
            snowButton.clipsToBounds = true
            snowButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
            animateSnowFlake()
        }
    }
    
    func animationSelector() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mainWeatherImageView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.mainWeatherImageView?.transform = CGAffineTransform.identity
            }
        }
    }
    
    func animateBackgroundRain() {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.backgroundColor = .white
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.view.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.5254901961, blue: 0.6705882353, alpha: 1)
            }
        }
    }
    
    private func animateSnowFlake() {
        guard let mainWeatherImageView = mainWeatherImageView else {return}
        let imageView = UIImageView()
        imageView.image = UIImage(named: "snowflake")
        imageView.frame = CGRect(origin: CGPoint(x: Int(mainWeatherImageView.frame.midX), y: Int(mainWeatherImageView.frame.maxY)), size: CGSize(width: 50, height: 50))
        view.addSubview(imageView)
        self.snowflake = imageView
        let endPoint = CGPoint(x: imageView.frame.origin.x, y: view.frame.height)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat], animations: {
            imageView.frame.origin = endPoint
            imageView.alpha = 0
        }, completion: { _ in
            imageView.frame.origin.y = mainWeatherImageView.frame.maxY
            imageView.alpha = 1
        })
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 2
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: "rotateAnimation")
    }
    
    private func sunAnimation() {
        guard let mainWeatherImageView = mainWeatherImageView else {return}
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 5
        rotationAnimation.repeatCount = .infinity
        mainWeatherImageView.layer.add(rotationAnimation, forKey: "rotateAnimation")
    }
    
}

extension ViewController {
    private func configureUI(){
        configureMainWeatherImageView()
    }
    
    private func configureMainWeatherImageView() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunBig")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
                    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    imageView.widthAnchor.constraint(equalToConstant: 300),
                    imageView.heightAnchor.constraint(equalToConstant: 300)
                ])
        
        self.mainWeatherImageView = imageView
    }
    
}
