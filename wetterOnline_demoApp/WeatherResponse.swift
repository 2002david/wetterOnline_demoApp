//
//  WeatherResponse.swift
//  wetterOnline_demoApp
//
//  Created by David on 05.08.25.
//

import Foundation

// OpenWeatherMap Response (API-Model)
struct WeatherResponse: Decodable {
    let main: Main
    let weather: [WeatherEntry]

    struct Main: Decodable {
        let temp: Double
    }

    struct WeatherEntry: Decodable {
        let description: String
    }
}
