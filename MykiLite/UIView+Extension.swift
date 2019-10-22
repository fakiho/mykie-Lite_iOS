//
//  UIView+Extension.swift
//  MykiLite
//
//  Created by Ali Fakih on 10/22/19.
//  Copyright © 2019 myki. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    enum Anchors {
          case left
          case top
          case right
          case bottom
      }
    
    /// Sets the left, right, top and bottom anchor, so the view fits it's container.
    /// - parameter container: The container for which this view will be a child of.
    /// - parameter anchors: The anchors that should be activated for the container.
    /// - parameter margins: The margins around view.
    func setFillingConstraints(in container: UIView,
                               anchors: [Anchors] = [.left, .top, .right, .bottom],
                               margins: UIEdgeInsets = UIEdgeInsets.zero) {
        translatesAutoresizingMaskIntoConstraints = false
        for anchor in anchors {
            switch anchor {
            case .left:
                leftAnchor.constraint(equalTo: container.leftAnchor, constant: margins.left).isActive = true
            case .top:
                topAnchor.constraint(equalTo: container.topAnchor, constant: margins.top).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: container.rightAnchor, constant: margins.right).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: margins.bottom).isActive = true
            }
        }
        setNeedsUpdateConstraints()
    }
    
    func topAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func topAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func bottomAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func bottomAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func leftAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func rightAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func widthAnchor(to constant: CGFloat) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func widthAnchor(greatherThenOrEqualTo constant: CGFloat) {
        widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }

    func heightAnchor(to constant: CGFloat) {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func heightAnchor(greatherThenOrEqualTo constant: CGFloat) {
        heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }

    func firstBaselineAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        firstBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func leadingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func leadingAnchor(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func trailingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func trailingAnchor(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
    }

    func centerXAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }

    func centerYAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
}
