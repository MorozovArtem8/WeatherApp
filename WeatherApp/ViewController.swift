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
    
    private weak var imageView: UIImageView?
    
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
            sunButton.layer.cornerRadius = 15
            sunButton.clipsToBounds = true
            sunButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
            
        case .rain:
            rainButton.layer.cornerRadius = 15
            rainButton.clipsToBounds = true
            rainButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
        case .clouds:
            cloudsButton.layer.cornerRadius = 15
            cloudsButton.clipsToBounds = true
            cloudsButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
        case .snow:
            snowButton.layer.cornerRadius = 15
            snowButton.clipsToBounds = true
            snowButton.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2941176471, blue: 0.3294117647, alpha: 1)
        }
    }
    
    
    
    
}

extension ViewController {
    private func configureUI(){
        configureImageView()
    }
    
    private func configureImageView() {
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
        
        self.imageView = imageView
    }
}
