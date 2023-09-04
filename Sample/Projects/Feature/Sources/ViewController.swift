//
//  ViewController.swift
//  Feature
//
//  Created by 김승찬 on 2023/08/31.
//  Copyright © 2023 seungchan. All rights reserved.
//

import Combine
import UIKit

import Service

infix operator ~>: LogicalDisjunctionPrecedence

public class ViewController: UIViewController {
    
    private lazy var button = UIButton()

    public var viewModelLogic: ViewModelLogic?
    private var cancelBag = CancelBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.setStyle()
        self.bind()
    }
    
    @objc func buttonDidTapped() {
        viewModelLogic?.input.tapButtonAction()
    }
}

private extension ViewController {
    
    func setStyle() {
        make(
            component { self.button } ~> addSubView(view)
            ~> map { button -> UIButton in
                guard let button = button as? UIButton else { return UIButton() }
                button.backgroundColor = .blue
                button.addTarget(self,
                                 action: #selector(self.buttonDidTapped),
                                 for: .touchUpInside)
                return button
            }
            ~> map { button -> UIButton in
                button.centerXAnchor ~> self.view.centerXAnchor
                button.centerYAnchor ~> self.view.centerYAnchor
                button.widthAnchor ~> 50
                button.heightAnchor ~> 50
                return button
            })
    }
    
    func bind() {
        viewModelLogic?.output.backgroundPublisher.sink(receiveValue: { [weak self] color in
            guard let self = self else { return }
            self.view.backgroundColor = color
        }).store(in: cancelBag)
    }
}

extension ViewController {
    public static func instance(viewModelLogic: ViewModelLogic = ViewModel()) -> ViewController {
        let viewController = ViewController()
        viewController.viewModelLogic = viewModelLogic
        return viewController
    }
}
