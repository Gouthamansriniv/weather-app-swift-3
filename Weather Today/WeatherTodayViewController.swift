//
//  WeatherTodayViewController.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/7/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherTodayViewController: UIViewController, CLLocationManagerDelegate {
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
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var currentWeatherViewModel: CurrentWeatherViewModel!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Today"
        
        // location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkForGrantedLocationPermissions()
    }
    
    // MARK: - View Methods
    
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    func checkForGrantedLocationPermissions() {
        let locationPermissionsStatus = CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        print("locationPermissionsStatus: \(CLLocationManager.authorizationStatus().hashValue)")
        if locationPermissionsStatus {
            currentLocation = locationManager.location
            Coordinate.sharedInstance.latitude = currentLocation.coordinate.latitude
            Coordinate.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            self.locationManager.requestLocation()
            self.getCurrentWeather()
        } else {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "RequestPermissions") {
                navigationController?.present(vc, animated: true)
            }
        }
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
        let sharedText = "\(self.currentWeatherViewModel.cityName!.uppercased())'s temperature ---> \(self.currentWeatherViewModel.temperature!)"
        let activityController = UIActivityViewController(activityItems: [sharedText, self.currentWeatherViewModel.icon!], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    func getCurrentWeather() {
        toggleRefreshAnimation(on: true)
        DispatchQueue.main.async {
            self.client.getCurrentWeather(at: Coordinate.sharedInstance) { [unowned self] currentWeather, error in
                if let currentWeather = currentWeather {
                    self.currentWeatherViewModel = CurrentWeatherViewModel(model: currentWeather)
                    self.displayWeather(using: self.currentWeatherViewModel)
                    self.toggleRefreshAnimation(on: false)
                }
            }
        }
    }
    
    
    // new location data is available
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // update shaped instance
        Coordinate.sharedInstance.latitude = (manager.location?.coordinate.latitude)!
        Coordinate.sharedInstance.longitude = (manager.location?.coordinate.longitude)!
        // request current weather
        self.getCurrentWeather()
    }
    
    // the location manager was unable to retrieve a location value
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        checkForGrantedLocationPermissions()
    }
    
    func toggleRefreshAnimation(on: Bool) {
        if on {
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
