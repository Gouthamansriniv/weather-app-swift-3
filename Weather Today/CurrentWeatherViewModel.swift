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
    var cityName: String?
    var temperature: String?
    var weatherCondition: String?
    var humidity: String?
    var precipitationProbability: String?
    var pressure: String?
    var windSpeed: String?
    var windDeg: Double?
    var windDirection: String?
    var icon: UIImage?
    private let defaultString = "-"
    
    init(model: CurrentWeather) {
        self.cityName = model.cityName
        self.weatherCondition = model.weatherCondition
        
        self.temperature = self.formatValue(value: model.temperature, endStringWith: "°")
        
        
        self.humidity = self.formatValue(value: model.humidity, endStringWith: "%")
        
        self.precipitationProbability = self.formatValue(value: model.precipitationProbability, endStringWith: " mm", castToInt: false)
        
        self.pressure = self.formatValue(value: model.pressure, endStringWith: " hPa")
        
        self.windSpeed = self.formatValue(value: model.windSpeed, endStringWith: " km/h")
        
        self.windDeg = model.windDeg
        
        self.windDirection = "NE"
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
    }
    
    func formatValue(value: Double, endStringWith: String = "", castToInt: Bool = true) -> String {
        var returnValue: String
        
        if value == Double.infinity {
            returnValue = self.defaultString
        } else if castToInt {
            returnValue = "\(Int(value))"
        } else {
            returnValue = "\(value)"
        }
        
        return returnValue.appending(endStringWith)
    }
}
