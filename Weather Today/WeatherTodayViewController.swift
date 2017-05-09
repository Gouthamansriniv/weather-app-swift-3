//
//  WeatherTodayViewController.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/7/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit

class WeatherTodayViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet var weatherImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherConditionLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var precipitationLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    
    let client = OpenWeatherMapAPIClient()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Today"
        
        let coordinate = Coordinate(latitude: 37.8269, longitude: -122.4233)
        
        client.getCurrentWeather(at: coordinate) { currentWeather, error in
            if let currentWeather = currentWeather {
                let currentWeatherViewModel = CurrentWeatherViewModel(model: currentWeather)
                self.displayWeather(using: currentWeatherViewModel)
            }
        }
    }
    
    // MARK: - View Methods
    
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
