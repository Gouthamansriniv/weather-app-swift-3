//
//  WeatherIcon.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/6/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import Foundation
import UIKit

enum WeatherIcon {
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
    case `default`
    
    init(iconString: String) {
        switch iconString {
        case "01d": self = .clearSky
        case "02d": self = .fewClouds
        case "03d": self = .scatteredClouds
        case "04d": self = .brokenClouds
        case "09d": self = .showerRain
        case "10d": self = .rain
        case "11d": self = .thunderstorm
        case "13d": self = .snow
        case "50d": self = .mist
        default: self = .default
        }
    }
}

extension WeatherIcon {
    var image: UIImage {
        switch self {
        case .clearSky: return #imageLiteral(resourceName: "ClearSkyIcon")
        case .fewClouds: return #imageLiteral(resourceName: "FewCloudsIcon")
        case .scatteredClouds: return #imageLiteral(resourceName: "ScatteredCloudsIcon")
        case .brokenClouds: return #imageLiteral(resourceName: "BrokenCloudsIcon")
        case .showerRain: return #imageLiteral(resourceName: "ShowerRainIcon")
        case .rain: return #imageLiteral(resourceName: "RainIcon")
        case .thunderstorm: return #imageLiteral(resourceName: "ThunderstormIcon")
        case .snow: return #imageLiteral(resourceName: "SnowIcon")
        case .mist: return #imageLiteral(resourceName: "CloudFogIcon")
        case .default: return #imageLiteral(resourceName: "ClearSkyIcon")
        }
    }
    
}
