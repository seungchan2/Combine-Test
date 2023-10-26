//
//  ListViewController.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/08.
//  Copyright © 2023 seungchan. All rights reserved.
//

import Combine
import UIKit

import Service

infix operator ~>: LogicalDisjunctionPrecedence

public final class ListViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        return flowLayout
    }()
    
    private var cancelBag = CancelBag()
    public var viewModel: ListViewModel

    public init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setDelegate()
    }
}

private extension ListViewController {
    func setStyle() {
        make(
            component { self.collectionView } ~> addSubView(view)
            ~> map { collectionView -> UICollectionView in
                guard let collectionView = collectionView as? UICollectionView else { return UICollectionView() }
                collectionView.register(MusicCell.self, forCellWithReuseIdentifier: MusicCell.identifier)
                return collectionView
            }
            ~> map { collectionView -> UICollectionView in
                collectionView.topAnchor ~> self.view.topAnchor
                collectionView.bottomAnchor ~> self.view.bottomAnchor
                collectionView.leftAnchor ~> self.view.leftAnchor
                collectionView.rightAnchor ~> self.view.rightAnchor
                return collectionView
            })
    }
    
    func setDelegate() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func bind() {
//        let input = ListViewModel.Input(userTap: <#T##Driver<Void>#>, webViewTap: <#T##Driver<Void>#>)
        
//        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }
}

extension ListViewController: UICollectionViewDelegate {}

extension ListViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCell.identifier, for: indexPath) as? MusicCell else { return UICollectionViewCell() }
        
        return cell

    }
}
