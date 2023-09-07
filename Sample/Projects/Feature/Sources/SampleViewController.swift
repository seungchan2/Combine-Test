//
//  SampleViewController.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/04.
//  Copyright © 2023 seungchan. All rights reserved.
//

import Combine
import UIKit

import Service

infix operator ~>: LogicalDisjunctionPrecedence

public final class SampleViewController: UIViewController {
    
    private lazy var button = UIButton()
    private lazy var webViewButton = UIButton()
    
    public var viewModel: SampleViewModel
    
    public lazy var buttonTapped = button.publisher(for: .touchUpInside).mapVoid().asDriver()
    public lazy var webViewButtonTapped = webViewButton.publisher(for: .touchUpInside).mapVoid().asDriver()
    private var cancelBag = CancelBag()
    
    public init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        style()
        bind()
    }

    private func style() {
        view.backgroundColor = .white
        make(
            component { self.button } ~> addSubView(view)
            ~> map { button -> UIButton in
                guard let button = button as? UIButton else { return UIButton() }
                button.backgroundColor = .blue
                return button
            }
            ~> map { button -> UIButton in
                button.centerXAnchor ~> self.view.centerXAnchor
                button.centerYAnchor ~> self.view.centerYAnchor
                button.widthAnchor ~> 50
                button.heightAnchor ~> 50
                return button
            })
        
        make(
            component { self.webViewButton } ~> addSubView(view)
            ~> map { button -> UIButton in
                guard let button = button as? UIButton else { return UIButton() }
                button.backgroundColor = .red
                return button
            }
            ~> map { button -> UIButton in
                button.centerXAnchor ~> self.view.centerXAnchor
                button.centerYAnchor ~> self.button.bottomAnchor - 200
                button.widthAnchor ~> 50
                button.heightAnchor ~> 50
                return button
            })
    }
    
    private func bind() {
        
        let input = SampleViewModel.Input(userTap: buttonTapped, webViewTap: webViewButtonTapped)
        
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        output.didChangedBackground
            .withUnretained(self)
            .sink(receiveValue: { owner, color in
                owner.view.backgroundColor = color
            })
            .store(in: cancelBag)
        
        output.pushWebView
            .sink { _ in
                let vc = WebViewController()
                self.present(vc, animated: true)
            }
            .store(in: cancelBag)
    }
}
