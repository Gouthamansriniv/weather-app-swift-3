//
//  CurrentWeatherViewModel.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/6/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    let cityName: String
    let temperature: String
    let weatherCondition: String
    let humidity: String
    let precipitationProbability: String
    let pressure: String
    let windSpeed: String
    let windDeg: String
    let windDirection: String
    let icon: UIImage
    
    init(model: CurrentWeather) {
        self.cityName = model.cityName
        
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)°"
        
        self.weatherCondition = model.weatherCondition
        
        let roundedHumidity = Int(model.humidity)
        self.humidity = "\(roundedHumidity)%"
        
        self.precipitationProbability = "\(model.precipitationProbability) mm"
        
        let roundedPressure = Int(model.pressure)
        self.pressure = "\(roundedPressure) hPa"
        
        let roundedWindSpeed = Int(model.windSpeed)
        self.windSpeed = "\(roundedWindSpeed) km/h"
        
        let roundedWindDeg = Int(model.windDeg)
        self.windDeg = "\(roundedWindDeg)"
        
        self.windDirection = "NE"
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
    }
    
    
    
    
}
