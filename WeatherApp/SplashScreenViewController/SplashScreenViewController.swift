import UIKit

class SplashScreenViewController: UIViewController {
    
    private weak var sunImage: UIImageView?
    private weak var rainImage: UIImageView?
    private weak var cloudsImage: UIImageView?
    private weak var snowImage: UIImageView?
    
    
    private var images: [UIImageView] = []
    private var timer: Timer?
    private var currentImagesInArray: Int = 0
    private var randomCount = 0
    private var randomCountChecker = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#2E86AB")
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimationCycle()
    }
    
    private func randomNumberInRange() -> Int {
        return Int.random(in: 5...10)
    }
    
    func animate(imageView: UIImageView?) {
        guard let imageView = imageView else { return }
        UIView.animate(withDuration: 0.15, delay: 0.0, options: [], animations: {
            imageView.transform = CGAffineTransform(translationX: 0, y: -20)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, animations: {
                imageView.transform = .identity
            })
        })
    }
    
    func startAnimationCycle() {
        randomCount = randomNumberInRange()
        timer = Timer.scheduledTimer(timeInterval: 0.32, target: self, selector: #selector(animateNextImage), userInfo: nil, repeats: true)
    }
    
    @objc func animateNextImage() {
        if currentImagesInArray == 4 {
            currentImagesInArray = 0
        }
        
        if randomCountChecker == randomCount {
            timer?.invalidate()
            timer = nil
            UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.images[self.currentImagesInArray].transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { _ in
                UIView.animate(withDuration: 0.8) {
                    self.images[self.currentImagesInArray].transform = CGAffineTransform.identity
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                let vc = MainViewController()
                vc.currentWeatherState = self.currentWeather()
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
        
        animate(imageView: images[currentImagesInArray])
        currentImagesInArray += 1
        randomCountChecker += 1
    }
    
    func currentWeather() -> CurrentWeather {
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

//MARK: Configure UI
private extension SplashScreenViewController {
    func configureUI() {
        configureStackViewAndImageView()
    }
    
    func configureStackViewAndImageView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.contentMode = .scaleToFill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let sunImage = UIImageView()
        sunImage.image = UIImage(named: "sunButton")
        sunImage.translatesAutoresizingMaskIntoConstraints = false
        self.sunImage = sunImage
        
        let rainImage = UIImageView()
        rainImage.image = UIImage(named: "rainButton")
        rainImage.translatesAutoresizingMaskIntoConstraints = false
        self.rainImage = rainImage
        
        let cloudsImage = UIImageView()
        cloudsImage.image = UIImage(named: "cloudsButton")
        cloudsImage.translatesAutoresizingMaskIntoConstraints = false
        self.cloudsImage = cloudsImage
        
        let snowImage = UIImageView()
        snowImage.image = UIImage(named: "snowButton")
        snowImage.translatesAutoresizingMaskIntoConstraints = false
        self.snowImage = snowImage
        
        stackView.addArrangedSubview(sunImage)
        stackView.addArrangedSubview(rainImage)
        stackView.addArrangedSubview(cloudsImage)
        stackView.addArrangedSubview(snowImage)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        images = [sunImage, rainImage, cloudsImage, snowImage]
    }
}
