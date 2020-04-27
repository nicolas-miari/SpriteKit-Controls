//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/27.
//

#if os(macOS)

import SpriteKit

/**
 Custom SKView subclass used to track mouse movement and implement a 'hover'
 (a.k.a. 'mouse over') behaviour for buttons.

 This is only needed for the mouse-based **macOS** platform: on the touch-based
 iOS, there is no 'mouse over': the finger position is unknown until it touches
 the screen, which is counterpart to the **mouse down** event.
 */
open class TrackingView: SKView {

    private var trackingArea: NSTrackingArea?

    private var nodeUnderMousePointer: SKNode?

    private var currentScene: SKScene! {
        guard let scene = self.scene else {
            fatalError("")
        }
        return scene
    }

    open override func updateTrackingAreas() {
        /*
         Taken from: https://stackoverflow.com/a/41878227/433373
         */
        if trackingArea != nil {
            self.removeTrackingArea(trackingArea!)
        }
        let options: NSTrackingArea.Options =
            [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow]
        trackingArea = NSTrackingArea(rect: self.bounds, options: options,
                                      owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }

    open override func mouseMoved(with event: NSEvent) {
        let location = event.location(in: currentScene)
        let node = currentScene.atPoint(location)

        if node != nodeUnderMousePointer {
            // Exit old node:
            nodeUnderMousePointer?.mouseExited(with: event)

            // Enter new node:
            node.mouseEntered(with: event)

            // Update reference:
            self.nodeUnderMousePointer = node
        } else {
            // Mode inside same node:
            nodeUnderMousePointer?.mouseMoved(with: event)
        }
    }

    /**
     (all other mouse vent handlers work as expected using
      the default implementations)
     */

    open override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
    }
}
#endif
