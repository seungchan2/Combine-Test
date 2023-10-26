//
//  ListViewModel.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/08.
//  Copyright © 2023 seungchan. All rights reserved.
//

import UIKit
import Combine

import Service

public final class ListViewModel: ViewModelType {
    
    private var cancelBag = CancelBag()

    public init() {}
    public struct Input {
        let userTap: Driver<Void>
        let webViewTap: Driver<Void>
    }
    
    public struct Output {
    }
    
    public func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
      
        return output
    }
}

