//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/26.
//

import SpriteKit

open class Button: Control {

    // MARK: - iOS

    #if os(iOS)
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
    #endif

    // MARK: - macOS

    #if os(macOS)

    open override func mouseEntered() {
        self.state = .highlighted
        super.mouseEntered()
    }

    open override func mouseDown() {
        self.state = .selected
        super.mouseDown()
    }

    open override func mouseDragExit() {
        self.state = .normal
        super.mouseDragExit()
    }

    open override func mouseDragEnter() {
        self.state = .selected
        super.mouseDragEnter()
    }

    open override func mouseUpInside() {
        self.state = .highlighted
        super.mouseUpInside()
    }

    open override func mouseExited() {
        self.state = .normal
        super.mouseExited()
    }

    /**
     Convenient shortcut for addHandler(_:for:) fixed on the `.mouseUpInside`
     event most common fir button controls.
     */
    public func addHandler(_ handler: @escaping Handler) {
        super.addHandler(handler, for: .mouseUpInside)
    }
    #endif
}
