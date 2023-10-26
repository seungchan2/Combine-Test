//
//  SampleViewModel.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/04.
//  Copyright © 2023 seungchan. All rights reserved.
//

import UIKit
import Combine

import Service

public struct WeatherInformation: Hashable {
    let name: String
}

public final class SampleViewModel: ViewModelType {
    
    private var cancelBag = CancelBag()
    public var networkProvider: WeatherService?

    var data = PassthroughSubject<[WeatherInformation], Never>()

    public init(networkProvider: WeatherService) {
        self.networkProvider = networkProvider
    }
    
    public struct Input {
        let userTap: Driver<Void>
        let webViewTap: Driver<Void>
    }
    
    public struct Output {
        let didChangedBackground = PassthroughSubject<UIColor, Never>()
        let weatherData = PassthroughSubject<[WeatherInformation], Never>()
        let pushWebView = PassthroughSubject<String, Never>()
    }
    
    public func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        input.userTap
            .flatMap { _ in
                if let networkProvider = self.networkProvider {
                    return networkProvider.getCurrentWeather(for: "Seoul")
                } else {
                    return Empty<Weathers, NetworkError>().eraseToAnyPublisher()
                }
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { weather in
                let weatherInformation = [WeatherInformation(name: weather.name)]
                self.data.send(weatherInformation)
                output.weatherData.send(weatherInformation)
            })
            .store(in: cancelBag)
        
        input.webViewTap
            .sink { _ in
                output.pushWebView.send("https://www.youtube.com/watch?v=8Kv2CKipG-Y")
            }
            .store(in: cancelBag)
        
        return output
    }
}
