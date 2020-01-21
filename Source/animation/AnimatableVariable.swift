//
//  AnimatableVariable.swift
//  Pods
//
//  Created by Yuri Strot on 8/24/16.
//
//

import Foundation

open class AnimatableVariable<T>: Variable<T> {
    unowned internal var node: Node?
}
