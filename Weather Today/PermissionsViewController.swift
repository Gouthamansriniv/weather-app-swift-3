//
//  PermissionsViewController.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/9/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import UIKit
import CoreLocation

class PermissionsViewController: UIViewController {
    // MARK: - Properties
    let locationManager = CLLocationManager()
    
    @IBOutlet var messagePermissionsLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkForGrantedLocationPermissions()
    }
    
    // MARK: - View Methods
    
    @IBAction func askForLocationPermissions() {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined:
                // The user has not yet made a choice regarding whether this app can use location services, then request permissions to use Location on foreground
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                self.displayLocationPermissionsDenied()
                // show alert
                let alert = UIAlertController(title: "Alert", message: Constants.ACTIVE_LOCATION_PERMISSIONS, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .authorizedAlways, .authorizedWhenInUse:
                self.authorizationCompleted()
            }
        } else {
            // Location services are not enabled
            self.displayLocationPermissionsDenied()
        }
    }
    
    func checkForGrantedLocationPermissions() {
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.manageLocationStatus(status: CLLocationManager.authorizationStatus())
            } else {
                self.displayLocationPermissionsDenied()
            }
        }
    }
    
    func manageLocationStatus(status: CLAuthorizationStatus) {
        switch(status) {
        case .notDetermined:
            self.displayLocationPermissionsNotDeterminated()
        case .restricted, .denied:
            self.displayLocationPermissionsDenied()
        case .authorizedAlways, .authorizedWhenInUse:
            self.authorizationCompleted()
        }
    }
    
    func displayLocationPermissionsDenied() {
        self.messagePermissionsLabel.text = Constants.MESSAGE_DENIED_LOCATION_PERMISSIONS
    }
    
    func displayLocationPermissionsNotDeterminated() {
        self.messagePermissionsLabel.text = Constants.MESSAGE_REQUEST_LOCATION_PERMISSIONS
    }
    
    func authorizationCompleted() {
        dismiss(animated: true)
    }

}

extension PermissionsViewController: CLLocationManagerDelegate {
    // the authorization status for the application changed
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus){
        self.manageLocationStatus(status: status)
    }
}
