//
//  MusicCell.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/07.
//  Copyright © 2023 seungchan. All rights reserved.
//

import UIKit

import Service

infix operator ~>: LogicalDisjunctionPrecedence

public final class MusicCell: UICollectionViewCell {
    
    static let identifier = "MusicCell"
    
    let titleLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.backgroundColor = .yellow
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        make(
            component { self.titleLabel } ~> addSubView(contentView)
            ~> map { label -> UILabel in
                guard let label = label as? UILabel else { return UILabel() }
                label.textColor = .red
                label.text = "현석ㅇㅣ 바보 !"
                return label
            }
            ~> map { label -> UILabel in
                label.centerXAnchor ~> self.contentView.centerXAnchor
                label.centerYAnchor ~> self.contentView.centerYAnchor
                return label
            })
    }
}

