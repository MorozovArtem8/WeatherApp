//  Created by Artem Morozov on 17.07.2024.

import UIKit

protocol MainViewControllerProtocol: AnyObject{
    var presenter: MainViewPresenterProtocol { get set }
    
    func updateUI(userSelected: CurrentWeather)
}

final class MainViewController: UIViewController & MainViewControllerProtocol {
    var presenter: MainViewPresenterProtocol
    
    init(presenter: MainViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private weak var sunButton: UIButton?
    private weak var rainButton: UIButton?
    private weak var cloudsButton: UIButton?
    private weak var snowButton: UIButton?
    
    private weak var stackView: UIStackView?
    private weak var weatherLabel: UILabel?
    
    private weak var mainWeatherImageView: UIImageView?
    private weak var snowflake: UIImageView?
    
    private var buttons = [UIButton?]()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewUpdateUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#2E86AB")
        configureUI()
        presenter.viewDidLoad()
        
    }
    
    func updateUI(userSelected: CurrentWeather) {
        mainWeatherImageView?.layer.removeAllAnimations()
        snowflake?.layer.removeAllAnimations()
        snowflake?.removeFromSuperview()
        resetSelectButtons()
        selectButton(userSelected: userSelected)
    }
    
    private func resetSelectButtons() {
        
        for button in buttons {
            button?.backgroundColor = .clear
        }
    }
    
    private func selectButton(userSelected: CurrentWeather) {
        switch userSelected {
        case .sun:
            self.mainWeatherImageView?.image = UIImage(named: "sunBig")
            weatherLabel?.text = userSelected.localized
            sunButton?.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
            sunAnimation()
            
        case .rain:
            self.mainWeatherImageView?.image = UIImage(named: "rainBig")
            weatherLabel?.text = userSelected.localized
            rainButton?.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
            animateBackgroundRain()
            
        case .clouds:
            self.mainWeatherImageView?.image = UIImage(named: "cloudsBig")
            weatherLabel?.text = userSelected.localized
            cloudsButton?.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
            
        case .snow:
            self.mainWeatherImageView?.image = UIImage(named: "snowBig")
            weatherLabel?.text = userSelected.localized
            snowButton?.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            animationSelector()
            animateSnowFlake()
        }
    }
    
    private func animationSelector() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mainWeatherImageView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.mainWeatherImageView?.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func animateBackgroundRain() {
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

//MARK: Configure UI
private extension MainViewController {
    func configureUI(){
        configureStackViewAndButton()
        configureMainWeatherImageView()
        configureWeatherLabel()
        buttons = [sunButton, rainButton, cloudsButton, snowButton]
    }
    
    func configureStackViewAndButton() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let sunButton = UIButton(type: .custom)
        sunButton.layer.cornerRadius = 15
        sunButton.clipsToBounds = true
        
        sunButton.setImage(UIImage(named: "sunButton"), for: .normal)
        sunButton.addTarget(self, action: #selector(sunButtonDidTapped), for: .touchUpInside)
        sunButton.translatesAutoresizingMaskIntoConstraints = false
        self.sunButton = sunButton
        
        let rainButton = UIButton(type: .custom)
        rainButton.setImage(UIImage(named: "rainButton"), for: .normal)
        rainButton.layer.cornerRadius = 15
        rainButton.clipsToBounds = true
        rainButton.addTarget(self, action: #selector(rainButtonDidTapped), for: .touchUpInside)
        rainButton.translatesAutoresizingMaskIntoConstraints = false
        self.rainButton = rainButton
        
        let cloudsButton = UIButton(type: .custom)
        cloudsButton.setImage(UIImage(named: "cloudsButton"), for: .normal)
        cloudsButton.layer.cornerRadius = 15
        cloudsButton.clipsToBounds = true
        cloudsButton.addTarget(self, action: #selector(cloudsButtonDidTapped), for: .touchUpInside)
        cloudsButton.translatesAutoresizingMaskIntoConstraints = false
        self.cloudsButton = cloudsButton
        
        let snowButton = UIButton(type: .custom)
        snowButton.setImage(UIImage(named: "snowButton"), for: .normal)
        snowButton.layer.cornerRadius = 15
        snowButton.clipsToBounds = true
        snowButton.addTarget(self, action: #selector(snowButtonDidTapped), for: .touchUpInside)
        snowButton.translatesAutoresizingMaskIntoConstraints = false
        self.snowButton = snowButton
        
        stackView.addArrangedSubview(sunButton)
        stackView.addArrangedSubview(rainButton)
        stackView.addArrangedSubview(cloudsButton)
        stackView.addArrangedSubview(snowButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureMainWeatherImageView() {
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
    
    func configureWeatherLabel() {
        guard let mainWeatherImageView = mainWeatherImageView else {return}
        let weatherLabel = UILabel()
        weatherLabel.text = "Hello"
        weatherLabel.textColor = .black
        weatherLabel.textAlignment = .center
        weatherLabel.font = UIFont.boldSystemFont(ofSize: 30)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherLabel)
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: mainWeatherImageView.bottomAnchor, constant: 20),
            weatherLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.weatherLabel = weatherLabel
        
    }
    
    @objc func sunButtonDidTapped() {
        presenter.didTapSunButton()
    }
    
    @objc func rainButtonDidTapped() {
        presenter.didTapRainButton()
    }
    
    @objc func cloudsButtonDidTapped() {
        presenter.didTapCloudButton()
    }
    
    @objc func snowButtonDidTapped() {
        presenter.didTapSnowButton()
    }
    
}


