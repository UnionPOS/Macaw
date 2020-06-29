//
//  Common_iOS.swift
//  Macaw
//
//  Created by Daniil Manin on 8/10/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit

public typealias MWindow = UIWindow
public typealias MRectCorner = UIRectCorner
public typealias MFont = UIFont
public typealias MFontDescriptor = UIFontDescriptor
public typealias MColor = UIColor
public typealias MEvent = UIEvent
public typealias MTouch = UITouch
public typealias MImage = UIImage
public typealias MBezierPath = UIBezierPath
public typealias MGestureRecognizer = UIGestureRecognizer
public typealias MGestureRecognizerState = UIGestureRecognizer.State
public typealias MGestureRecognizerDelegate = UIGestureRecognizerDelegate
public typealias MTapGestureRecognizer = UITapGestureRecognizer
public typealias MLongPressGestureRecognizer = UILongPressGestureRecognizer
public typealias MPanGestureRecognizer = UIPanGestureRecognizer
public typealias MPinchGestureRecognizer = UIPinchGestureRecognizer
public typealias MRotationGestureRecognizer = UIRotationGestureRecognizer
public typealias MScreen = UIScreen
public typealias MViewContentMode = UIView.ContentMode

func MDefaultRunLoopMode() -> RunLoop.Mode {
    RunLoop.Mode.default
}

extension MTapGestureRecognizer {
    func mNumberOfTouches() -> Int {
        numberOfTouches
    }
}

extension MPanGestureRecognizer {
    func mNumberOfTouches() -> Int {
        numberOfTouches
    }

    func mLocationOfTouch(_ touch: Int, inView: UIView?) -> CGPoint {
        super.location(ofTouch: touch, in: inView)
    }
}

extension MRotationGestureRecognizer {
    final var mRotation: CGFloat {
        get {
            rotation
        }

        set {
            rotation = newValue
        }
    }
}

extension MPinchGestureRecognizer {
    var mScale: CGFloat {
        get {
            scale
        }

        set {
            scale = newValue
        }
    }

    func mLocationOfTouch(_ touch: Int, inView: UIView?) -> CGPoint {
        super.location(ofTouch: touch, in: inView)
    }
}

extension MFont {
    class var mSystemFontSize: CGFloat {
        UIFont.systemFontSize
    }

    class var mFamilyNames: [String] {
        UIFont.familyNames
    }

    class func mFontNames(forFamily: String) -> [String] {
        UIFont.fontNames(forFamilyName: forFamily)
    }
}

extension UIScreen {
    var mScale: CGFloat {
        self.scale
    }
}

extension UIBezierPath {
    var mUsesEvenOddFillRule: Bool {
        self.usesEvenOddFillRule
    }
}

#endif
