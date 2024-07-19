//  Created by Artem Morozov on 19.07.2024.

import Foundation

enum CurrentWeather {
    case sun
    case rain
    case clouds
    case snow
    
    var localized: String {
        switch self {
            
        case .sun:
            return "sunny".localized
        case .rain:
            return "rain".localized
        case .clouds:
            return "cloudy".localized
        case .snow:
            return "snow".localized
        }
    }
}
