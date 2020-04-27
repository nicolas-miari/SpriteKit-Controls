//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/26.
//

import SpriteKit

open class Button: Control {

    open override func touchDown() {
        self.state = .highlighted
        super.touchDown()
    }

    open override func touchUpInside() {
        self.state = .normal
        super.touchUpInside()
    }

    open override func touchDragExit() {
        self.state = .normal
        super.touchDragExit()
    }

    open override func touchDragEnter() {
        self.state = .highlighted
        super.touchDragEnter()
    }

    /**
     Convenient shortcut for addHandler(_:for:) fixed on the `.touchUpInside`
     event most common fir button controls.
     */
    public func addHandler(_ handler: @escaping Handler) {
        super.addHandler(handler, for: .touchUpInside)
    }
}
