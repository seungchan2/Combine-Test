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

public final class SampleViewModel: ViewModelType {
    
    private var cancelBag = CancelBag()
    public var networkProvider: WeatherService?
    
    public init(networkProvider: WeatherService) {
        self.networkProvider = networkProvider
    }
   
    public struct Input {
        let userTap: Driver<Void>
    }
    
    public struct Output {
        let didChangedBackground = PassthroughSubject<UIColor, Never>()
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
                print(weather)
            })
            .store(in: cancelBag)


        
        return output
    }
}
