//
//  WeatherService.swift
//  wetterOnline_demoApp
//
//  Created by David on 05.08.25.
//

import Foundation

class WeatherService: ObservableObject {
    @Published var weather: Weather?

    private let session: URLSession
    private let apiKey: String

    init(session: URLSession = .shared) {
        self.session = session

        guard let key = Bundle.main.infoDictionary?["OPENWEATHERMAP_API_KEY"] as? String else {
            fatalError("API Key fehlt in Info.plist")
        }
        self.apiKey = key
    }

    func fetchWeather(for city: String) {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&appid=\(apiKey)&units=metric&lang=de"
        
        print("cityEncoded: " + cityEncoded)
        print("urlString" + urlString)

        guard let url = URL(string: urlString) else {
            print("Ungültige URL")
            return
        }

        session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Netzwerkfehler: \(error?.localizedDescription ?? "Unbekannt")")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)

                let weather = Weather(
                    temperature: decoded.main.temp,
                    condition: decoded.weather.first?.description.capitalized ?? "Unbekannt"
                )

                DispatchQueue.main.async {
                    self?.weather = weather
                }
            } catch {
                print("Fehler beim Decoding: \(error)")
            }

        }.resume()
    }
}
