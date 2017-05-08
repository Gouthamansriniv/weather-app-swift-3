//
//  WeatherTodayViewController.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/7/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit

class WeatherTodayViewController: UIViewController {
    
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var precipitationLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    
    fileprivate let openWeatherMapKey = "933887d73fafeb70d31b6c5566986168"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Today"
        let currentWeather = CurrentWeather(cityName: "Dublin", temperature: 17.56, weatherCondition: "Sunny", humidity: 63, precipitationProbability: 0.1, pressure: 1009, windSpeed: 3.6, windDeg: 50, icon: "02d")
        let currentWeatherViewModel = CurrentWeatherViewModel(model: currentWeather)
        displayWeather(using: currentWeatherViewModel)
    }
    
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        self.cityNameLabel.text = viewModel.cityName
        self.temperatureLabel.text = viewModel.temperature
        self.weatherConditionLabel.text = viewModel.weatherCondition
        self.humidityLabel.text = viewModel.humidity
        self.precipitationLabel.text = viewModel.precipitationProbability
        self.pressureLabel.text = viewModel.pressure
        self.windSpeedLabel.text = viewModel.windSpeed
        self.windDirectionLabel.text = viewModel.windDirection
        self.weatherImageView.image = viewModel.icon
        
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
    }
    
    
}
