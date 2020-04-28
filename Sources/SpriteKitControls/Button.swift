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

    open override func press() {
        self.state = .selected
        super.press()
    }

    open override func releaseInside() {
        self.state = .normal
        super.releaseInside()
    }

    open override func pressDragExit() {
        self.state = .normal
        super.pressDragExit()
    }

    open override func pressDragEnter() {
        self.state = .selected
        super.pressDragEnter()
    }

    // Mac-specific

    open override func entered() {
        self.state = .highlighted
        super.entered()
    }

    open override func exited() {
        self.state = .normal
        super.exited()
    }

    /**
     Convenient shortcut for addHandler(_:for:) fixed on the `.releaseInside`
     event most common for button controls.
     */
    public func addHandler(_ handler: @escaping Handler) {
        super.addHandler(handler, for: .releaseInside)
    }
}
