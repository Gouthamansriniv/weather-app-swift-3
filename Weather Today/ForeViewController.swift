//
//  ForeViewController.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/6/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit
import CoreLocation

class ForeViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    
    let weatherDays:[String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var forecastWeatherViewModels: [ForecastWeatherViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currentWeatherViewModel.cityName
        
        // location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkPermissions()
    }
    
    func checkPermissions() {
        Coordinate.checkForGrantedLocationPermissions() { [unowned self] allowed in
            if allowed {
                self.locationManager.requestLocation()
                self.getForecastWeather()
            } else {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RequestPermissions") {
                    self.navigationController?.present(vc, animated: true)
                }
            }
        }
    }
    
    func getForecastWeather() {
        toggleRefreshAnimation(on: true)
        DispatchQueue.main.async {
            OpenWeatherMapAPIClient.client.getForecastWeather(at: Coordinate.sharedInstance) {
                [unowned self] forecastsWeather, error in
                if let forecastsWeather = forecastsWeather {
                    // reset self.forecastWeatherViewModels to avoid repeat items
                    if forecastsWeather.count > 0 {
                        self.forecastWeatherViewModels = []
                    }
                    
                    for forecastWeather in forecastsWeather {
                        let forecastWeatherVM = ForecastWeatherViewModel(model: forecastWeather)
                        self.forecastWeatherViewModels.append(forecastWeatherVM)
                    }
                    
                    self.tableView.reloadData()
                    self.toggleRefreshAnimation(on: false)
                }
            }
        }
    }
    
    func showPermissionsScreen() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: requestPermissionsIdentifier) {
            self.navigationController?.present(vc, animated: true)
        }
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

extension ForeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastWeatherViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastWeatherVM = self.forecastWeatherViewModels[indexPath.row]
        let cellIdentifier = "ForecastCell"
        
        // Dequeue Reusable Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ForecastDayTableViewCell
        
        // Configure Cell
        cell.weatherConditionImageView.image = forecastWeatherVM.icon
        cell.weekdayLabel.text = forecastWeatherVM.weekday
        cell.weatherConditionLabel.text = forecastWeatherVM.weatherCondition
        cell.temperatureLabel.text = forecastWeatherVM.temperature
        
        return cell
    }
}

extension ForeViewController: CLLocationManagerDelegate {
    // new location data is available
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // update shaped instance
        Coordinate.sharedInstance.latitude = (manager.location?.coordinate.latitude)!
        Coordinate.sharedInstance.longitude = (manager.location?.coordinate.longitude)!
        // request forecast weather
        self.getForecastWeather()
        print("didUpdateLocations")
    }
    
    // the location manager was unable to retrieve a location value
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        Coordinate.checkForGrantedLocationPermissions() { allowed in
            if !allowed {
                self.showPermissionsScreen()
            }
        }
    }
}
