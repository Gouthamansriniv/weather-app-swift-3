//
//  OpenWeatherMapAPIClient.swift
//  Weather Today
//
//  Created by Sebastián  Lara on 5/8/17.
//  Copyright © 2017 Sebastián  Lara. All rights reserved.
//

import Foundation
import Alamofire

class OpenWeatherMapAPIClient {
    fileprivate let apiKey = "933887d73fafeb70d31b6c5566986168"
    
    lazy var baseUrl: URL = {
        return URL(string: "http://api.openweathermap.org/data/2.5/weather/")!
    }()
    
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, OpenWeatherMapError?) -> Void
    
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        
        let parameters: Parameters = [
            "appid": self.apiKey,
            "units": "metric",
            "lat": String(coordinate.latitude),
            "lon": String(coordinate.longitude)
        ]
        
        Alamofire.request(baseUrl, parameters: parameters).responseJSON { response in
            guard let JSON = response.result.value as? Dictionary<String, AnyObject> else {
                completion(nil, .invalidaData)
                return
            }
            
            if response.response?.statusCode == 200 {
                guard let currentWeather = CurrentWeather(json: JSON) else {
                    completion(nil, .jsonParsingFailure)
                    return
                }
                
                completion(currentWeather, nil)
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
    }
    
}
