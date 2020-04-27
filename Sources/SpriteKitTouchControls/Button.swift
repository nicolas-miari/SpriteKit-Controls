//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/26.
//

import SpriteKit

open class Button: Control {

    open override func touchDown() {
        super.touchDown()
        self.state = .highlighted
    }

    open override func touchUpInside() {
        super.touchUpInside()
        self.state = .normal
    }

    open override func touchDragExit() {
        super.touchDragExit()
        self.state = .normal
    }

    open override func touchDragEnter() {
        super.touchDragEnter()
        self.state = .highlighted
    }

    public func addHandler(_ handler: @escaping Handler) {
        super.addHandler(handler, for: .touchUpInside)
    }
}
