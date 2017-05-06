//
//  WeatherDay.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/5/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit

class WeatherDay {
    var image: UIImage!
    var weekday: String!
    var weatherCondition: String!
    var temperature: Int!
    
    init(weekday: String, weatherCondition: String, temperature: Int) {
        self.image = UIImage(named: "AppLogo")
        self.weekday = weekday
        self.weatherCondition = weatherCondition
        self.temperature = temperature
    }
    
}
