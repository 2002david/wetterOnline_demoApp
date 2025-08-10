//
//  ContentView.swift
//  wetterOnline_demoApp
//
//  Created by David on 04.08.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherService = WeatherService()
    @State private var city: String = "Berlin"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Stadt eingeben", text: $city, onCommit: {
                weatherService.fetchWeather(for: city)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            if let weather = weatherService.weather {
                Text(city)
                    .font(.title)
                Text("\(Int(weather.temperature))°C")
                    .font(.system(size: 50))
                    .bold()
                Text(weather.condition)
                    .font(.title2)
            } else {
                Text("Keine Daten")
            }

            Spacer()
        }
        .padding()
        .onAppear {
            weatherService.fetchWeather(for: city)
        }
    }
}

#Preview {
    ContentView()
}
