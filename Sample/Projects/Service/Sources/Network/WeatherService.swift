//
//  WeatherService.swift
//  Service
//
//  Created by 김승찬 on 2023/09/04.
//  Copyright © 2023 seungchan. All rights reserved.
//

import Combine
import Foundation

public struct Weathers: Codable {
    let weather: [Weather]
    let main: WeatherMain
    let wind: WeatherWind
    let name: String
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct WeatherWind: Codable {
    let speed: Double
}

public enum NetworkError: Error {
    case invalidURL
    case requestFailed
}

public protocol WeatherService {
    func getCurrentWeather(for city: String) -> AnyPublisher<Weathers, NetworkError>
}


public final class DefaultWeatherService: WeatherService {
    
    public init() {}
    public func getCurrentWeather(for city: String) -> AnyPublisher<Weathers, NetworkError> {
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(api)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Weathers.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.requestFailed
            }
            .eraseToAnyPublisher()
    }
}
