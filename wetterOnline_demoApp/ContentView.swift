//
//  ContentView.swift
//  wetterOnline_demoApp
//
//  Created by David on 04.08.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherService = WeatherService()
    @State private var city: String = ""
    @State private var hasSearched = false
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            
            // Überschrift und Beschreibung
            VStack(alignment: .leading, spacing: 4) {
                        Text("Wetter")
                            .font(.largeTitle)
                            .bold()
                        Text("Gebe eine Stadt ein und erfahre das aktuelle Wetter.")
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .top])

            // Suche
            TextField("Stadt eingeben", text: $city, onCommit: {
                searchCity()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            // Wetteranzeige
            if hasSearched {
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else if let weather = weatherService.weather {
                    Text(city)
                        .font(.title)
                    Text("\(Int(weather.temperature))°C")
                        .font(.system(size: 50))
                        .bold()
                    Text(weather.condition)
                        .font(.title2)
                }
            }

            Spacer()
            
            HStack {
                Text("Made with ❤️ for WetterOnline by David Steglich!")
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
        }
        .padding()
    }

    func searchCity() {
        let trimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        hasSearched = true
        errorMessage = nil
        weatherService.weather = nil

        weatherService.fetchWeather(for: trimmed)
    }

}

#Preview {
    ContentView()
}

