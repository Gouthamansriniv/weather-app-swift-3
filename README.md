# Weather Today - Swift 3

![Language](https://img.shields.io/badge/Language-Swift%203-red.svg)
![Cocoapods](https://img.shields.io/badge/CocoaPods-latest-blue.svg)
![Firebase](https://img.shields.io/badge/Firebase--yellow.svg)
![License](https://img.shields.io/github/license/JakeLin/SwiftWeather.svg?style=flat)

Weather Today is a simple iOS app for weather forecasting. 

- It show the actual weather for your current location. In the forecast tab, show the forecast for the next 7 days at your current location. 

- This app support iOS 9+

## Weather Provider?

[OpenWeatherMap](http://openweathermap.org/api) API used as weather provider.

- Current Weather endpoint: ![view](http://api.openweathermap.org/data/2.5/forecast/daily?lat=4.5339&lon=-75.6812&cnt=7&mode=json&appid=933887d73fafeb70d31b6c5566986168)

- Forecast Weather enpoint used: ![view](http://api.openweathermap.org/data/2.5/forecast/daily/?appid=933887d73fafeb70d31b6c5566986168&lat=4.56521807401477&lon=-75.6534032286994&units=metric)

- Parameters of API respond: ![docs](http://openweathermap.org/weather-data)

## Firebase Database

Use ![Firebase Database](https://firebase.google.com/docs/database/ios/start) for simple storing of current location  and  temperature when this is available.

## Screenshots

![Custom UIView](https://cloud.githubusercontent.com/assets/8799407/25956990/dae5f4a8-3632-11e7-8111-c7e82150f769.png)

## How to build

1) Clone the repository

```bash
$ git clone https://github.com/jhoansebastianlara/weather-app-swift-3.git
```

2) Install pods

```bash
$ cd Weather\ Today/
$ pod install
```

3) Open the workspace in Xcode

```bash
$ open "Weather Today.xcworkspace"
```

4) Sign up on [openweathermap.org/appid](http://openweathermap.org/appid) to get an appid

*Please replace "your-openweathermap-appid" with your actual appid key.*

You should find `OpenWeatherMapAPIClient.swift` file and put your appid in the line 15:

``fileprivate let apiKey = "YOUR_ID"``
 
5) Compile and run the app in your simulator

6) If you don't see any data, please check "Simulator" -> "Debug" -> "Location" to change the location.

# Requirements

* Xcode 8
* iOS 9+
