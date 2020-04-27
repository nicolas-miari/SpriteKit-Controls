//
//  Button.swift
//  
//
//  Created by Nicolás Miari on 2020/04/26.
//

import SpriteKit

/**
 Control subclass that implements push-button-like behaviour.

 On macOS, the `mouseMoved(with:)` message isn't sent to instances of NSView
 (and by extension, SKView) by default when the mouse moves (`mouseDown(with:)`
 and `mouseUp(with:)` _are_). In order to be notified of mouse movement, and
 thus properly recognize the mouse entered, mouse exited, and various mouse drag
 events, a **tracking area**  needs to be properly set up in the view (see:
 https://stackoverflow.com/a/41878227/433373). To solve this, instead of
 using/subclassing SKView directly, use (or subclass) the provided TrackingView
 class, which is out-of-the-box wired to handle mouse movement.

 On iOS, there is no concept of "mouse over" (a button is not aware of the
 user's finger position until it actually touches the screen); just use this
 class like you woukld any other SKNode subclass.
 */
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
