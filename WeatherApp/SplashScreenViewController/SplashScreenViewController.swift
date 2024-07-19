//  Created by Artem Morozov on 18.07.2024.

import UIKit

protocol SplashScreenViewControllerProtocol: AnyObject {
    var presenter: SplashScreenViewPresenterProtocol {get set}
    
    func scrollAnimation(imageView: UIImageView?)
    func scaleAnimation(imageView: UIImageView?)
}

final class SplashScreenViewController: UIViewController & SplashScreenViewControllerProtocol {
    
    init(presenter: SplashScreenViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presenter: SplashScreenViewPresenterProtocol
    
    private weak var sunImage: UIImageView?
    private weak var rainImage: UIImageView?
    private weak var cloudsImage: UIImageView?
    private weak var snowImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#2E86AB")
        configureUI()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    func scrollAnimation(imageView: UIImageView?) {
        guard let imageView = imageView else { return }
        UIView.animate(withDuration: 0.15, delay: 0.0, options: [], animations: {
            imageView.transform = CGAffineTransform(translationX: 0, y: -20)
        }, completion: { _ in
            UIView.animate(withDuration: 0.15, animations: {
                imageView.transform = .identity
            })
        })
    }
    
    func scaleAnimation(imageView: UIImageView?) {
        guard let imageView = imageView else { return }
        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .autoreverse], animations: {
            imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { _ in
            UIView.animate(withDuration: 0.8) {
                imageView.transform = CGAffineTransform.identity
            }
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
        
        presenter.images = [sunImage, rainImage, cloudsImage, snowImage]
    }
}
