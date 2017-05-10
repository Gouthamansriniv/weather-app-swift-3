//
//  Coordinate.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/8/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import Foundation
import CoreLocation

struct Coordinate {
    static var sharedInstance = Coordinate(latitude: 0.0, longitude: 0.0)
    
//    init(latitude: Double, longitude: Double) {
//        self.latitude = latitude
//        self.longitude = longitude
//    }
    
    var latitude: Double
    var longitude: Double
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "&lat=\(latitude)&lon=\(longitude)"
    }
}
