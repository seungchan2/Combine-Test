//
//  ViewModel.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/04.
//  Copyright © 2023 seungchan. All rights reserved.
//

import Combine
import UIKit

public protocol ViewModelInputLogic {
    func tapButtonAction()
}

public protocol ViewModelOutputLogic {
    var backgroundPublisher: AnyPublisher<UIColor, Never> { get }
}

public protocol ViewModelLogic: AnyObject {
    var input: ViewModelInputLogic { get }
    var output: ViewModelOutputLogic { get }
}

public final class ViewModel: ViewModelLogic, ViewModelOutputLogic, ViewModelInputLogic  {
    
    public init() { }
    public var input: ViewModelInputLogic { self }
    public var output: ViewModelOutputLogic { self }

    private let backgroundSubject = PassthroughSubject<UIColor, Never>()
    
    public var backgroundPublisher: AnyPublisher<UIColor, Never> {
        return backgroundSubject.eraseToAnyPublisher()
    }

    public func tapButtonAction() {
        backgroundSubject.send(.yellow)
    }
}
