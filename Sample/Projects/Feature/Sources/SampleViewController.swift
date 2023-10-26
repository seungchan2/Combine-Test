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
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        return flowLayout
    }()
    
    public lazy var buttonTapped = button.publisher(for: .touchUpInside).mapVoid().asDriver()
    
    public lazy var webViewButtonTapped = webViewButton.publisher(for: .touchUpInside).mapVoid().asDriver()
    private var cancelBag = CancelBag()
    public var viewModel: SampleViewModel

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
                button.topAnchor ~> self.view.topAnchor + 100
                button.centerXAnchor ~> self.view.centerXAnchor
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
                button.bottomAnchor ~> self.button.bottomAnchor + 60
                button.widthAnchor ~> 50
                button.heightAnchor ~> 50
                return button
            })
        
        make(
            component { self.collectionView } ~> addSubView(view)
            ~> map { collectionView -> UICollectionView in
                guard let collectionView = collectionView as? UICollectionView else { return UICollectionView() }
                collectionView.register(MusicCell.self, forCellWithReuseIdentifier: MusicCell.identifier)
                return collectionView
            }
            ~> map { collectionView -> UICollectionView in
                collectionView.topAnchor ~> self.webViewButton.bottomAnchor + 30
                collectionView.bottomAnchor ~> self.view.bottomAnchor
                collectionView.leftAnchor ~> self.view.leftAnchor
                collectionView.rightAnchor ~> self.view.rightAnchor
                return collectionView
            })
    }
    
    private func bind() {
        let input = SampleViewModel.Input(userTap: buttonTapped,
                                          webViewTap: webViewButtonTapped)
        
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        output.didChangedBackground
            .withUnretained(self)
            .sink(receiveValue: { owner, color in
                owner.view.backgroundColor = color
            })
            .store(in: cancelBag)
        
        output.pushWebView
            .sink { url in
                let vc = WebViewController(url: WebURL(URL: url))
                self.present(vc, animated: true)
            }
            .store(in: cancelBag)
        
        output.weatherData
            .map { $0 }
            .asDriver()
          .subscribe(collectionView.itemsSubscriber(cellIdentifier: "MusicCell", cellType: MusicCell.self, cellConfig: { cell, indexPath, model in
              print(model)
              cell.backgroundColor = .red
              cell.titleLabel.text = model.name
          }))
        
    }
}
