//
//  UIFunctions.swift
//  Feature
//
//  Created by 김승찬 on 2023/09/04.
//  Copyright © 2023 seungchan. All rights reserved.
//

import UIKit

infix operator ~>: LogicalDisjunctionPrecedence

public let addSubView: (UIView) -> (UIView) -> UIView = { parent in
    { v in
        parent.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }
}

@discardableResult
public func ~> (left: UIView,
         right: UIView) -> UIView {
    
    left.topAnchor.constraint(equalTo: right.topAnchor).isActive = true
    left.leftAnchor.constraint(equalTo: right.leftAnchor).isActive = true
    left.rightAnchor.constraint(equalTo: right.rightAnchor).isActive = true
    left.bottomAnchor.constraint(equalTo: right.bottomAnchor).isActive = true
    return left
}

@discardableResult
public func ~> (left: NSLayoutYAxisAnchor,
         right: NSLayoutYAxisAnchor) -> NSLayoutYAxisAnchor {
    left.constraint(equalTo: right).isActive = true
    return left
}

@discardableResult
public func ~> (left: NSLayoutYAxisAnchor,
         right: (anchor: NSLayoutYAxisAnchor,
                 constant: CGFloat)) -> NSLayoutYAxisAnchor {
    left.constraint(equalTo: right.anchor,
                    constant: right.constant).isActive = true
    
    return left
}

public func + (left: NSLayoutYAxisAnchor,
        right: CGFloat) -> (anchor: NSLayoutYAxisAnchor,
                            constant: CGFloat) {
    (left, right)
}

public func - (left: NSLayoutYAxisAnchor,
        right: CGFloat) -> (anchor: NSLayoutYAxisAnchor,
                            constant: CGFloat) {
    (left, -right)
}

@discardableResult
public func ~> (left: NSLayoutXAxisAnchor,
         right: NSLayoutXAxisAnchor) -> NSLayoutXAxisAnchor {
    left.constraint(equalTo: right).isActive = true
    return left
}

@discardableResult
public func ~> (left: NSLayoutXAxisAnchor,
         right: (anchor: NSLayoutXAxisAnchor,
                 constant: CGFloat)) -> NSLayoutXAxisAnchor {
    left.constraint(equalTo: right.anchor,
                    constant: right.constant).isActive = true
    return left
}

public func + (left: NSLayoutXAxisAnchor,
        right: CGFloat) -> (anchor: NSLayoutXAxisAnchor,
                            constant: CGFloat) {
    (left, right)
}

public func - (left: NSLayoutXAxisAnchor,
        right: CGFloat) -> (anchor: NSLayoutXAxisAnchor,
                            constant: CGFloat) {
    (left, -right)
}

@discardableResult
public func ~> (left: NSLayoutDimension,
         right: CGFloat) -> NSLayoutDimension {
    left.constraint(equalToConstant: right).isActive = true
    return left
}

@discardableResult
public func ~> (left: NSLayoutDimension,
         right: NSLayoutDimension) -> NSLayoutDimension {
    left.constraint(equalTo: right, multiplier: 1).isActive = true
    return left
}

@discardableResult
public func ~> (left: NSLayoutDimension,
         right: (anchor: NSLayoutDimension,
                 multiplier: CGFloat)) -> NSLayoutDimension {
    left.constraint(equalTo: right.anchor,
                    multiplier: right.multiplier).isActive = true
    return left
}

public func * (left: NSLayoutDimension,
        right: CGFloat) -> (anchor: NSLayoutDimension,
                            multiplier: CGFloat) {
    (left, right)
}

public func / (left: NSLayoutDimension,
        right: CGFloat) -> (anchor: NSLayoutDimension,
                            multiplier: CGFloat) {
    (left, 1 / right)
}
