//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/28.
//

import SpriteKit

open class Control: SKSpriteNode {

    public static var soundHandler: ControlSoundHandler?

    public enum State {
        case normal
        case highlighted
        case selected
        case disabled
    }

    public enum Event {
        // macOS-only: corresponds to mouseEnter
        case enter

        // macOS-only: corresponds to mouseExit
        case exit

        case press

        case pressDragInside

        case pressDragExit

        case pressDragOutside

        case releaseOutside

        case pressDragEnter

        case releaseInside
    }

    public var state: State = .normal {
        didSet {
            if let texture = backgroundTextures[state] ?? backgroundTextures[.normal] {
                self.texture = texture
                self.size = texture.size()
            }
            self.isUserInteractionEnabled = (state != .disabled)
        }
    }

    public typealias Handler = (() -> Void)

    // MARK: -

    private var lastLocation: CGPoint?
    private var handlers: [Event: [Handler]] = [:]
    private var backgroundTextures: [State: SKTexture] = [:]

    // MARK: - Initialization

    public init(normalTexture: SKTexture) {
        super.init(texture: normalTexture, color: .white, size: normalTexture.size())
        self.backgroundTextures[.normal] = normalTexture
        self.isUserInteractionEnabled = true
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }

    override open func contains(_ p: CGPoint) -> Bool {
        let origin = CGPoint(
            x: position.x - (anchorPoint.x)*size.width,
            y: position.y - (anchorPoint.y)*size.height
        )
        let bounds = CGRect(origin: origin, size: size)
        return bounds.contains(p)
    }

    // MARK: - Operation

    public func addHandler(_ handler: @escaping Handler, for event: Event) {
        var handlersForEvent = handlers[event] ?? []
        handlersForEvent.append(handler)
        handlers[event] = handlersForEvent
    }

    public func setBackgroundTexture(_ backgroundTexture: SKTexture, for controlState: State) {
        self.backgroundTextures[controlState] = backgroundTexture
        if self.state == controlState {
            self.texture = backgroundTexture
        }
    }

    public func backgroundTexture(for state: State) -> SKTexture? {
        return backgroundTextures[state]
    }

    // MARK: - Intents

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func entered() {
        handleEvent(.enter)
    }

    open func exited() {
        handleEvent(.exit)
    }

    open func press() {
        handleEvent(.press)
    }

    open func pressDragInside() {
        handleEvent(.pressDragInside)
    }

    open func pressDragExit() {
        handleEvent(.pressDragExit)
    }

    open func pressDragOutside() {
        handleEvent(.pressDragOutside)
    }

    open func releaseOutside() {
        handleEvent(.releaseOutside)
    }

    open func pressDragEnter() {
        handleEvent(.pressDragEnter)
    }

    open func releaseInside() {
        handleEvent(.releaseInside)
    }

    private func handleEvent(_ event: Event) {
        Control.soundHandler?.playSound(for: event, of: self)
        handlers[event]?.forEach { $0() }
    }

    #if os(macOS)
    // MARK: - NSResponder

    override open func mouseDown(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        guard let parent = self.parent else { return }

        let location = event.location(in: parent)
        self.lastLocation = location

        guard self.contains(location) else {
            return
        }
        press()
    }

    override open func mouseEntered(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        guard let parent = self.parent else { return }

        let location = event.location(in: parent)
        self.lastLocation = location

        entered()
    }

    override open func mouseExited(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        guard let parent = self.parent else { return }

        let location = event.location(in: parent)
        self.lastLocation = location

        exited()
    }

    override open func mouseDragged(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        guard let parent = self.parent else { return }

        let location = event.location(in: parent)

        if let last = lastLocation {
            switch (self.contains(location), self.contains(last)) {
            case (true, true):
                pressDragInside()

            case (true, false):
                pressDragEnter()

            case (false, true):
                pressDragExit()

            case (false, false):
                pressDragOutside()
            }
        }

        self.lastLocation = location
    }

    override open func mouseUp(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        guard let parent = self.parent else { return }

        let location = event.location(in: parent)
        if self.contains(location) {
            releaseInside()
        } else {
            releaseOutside()
        }
    }
    #endif

    #if os(iOS)
    // MARK: - UIResponder

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let parent = self.parent else {
            return
        }
        guard let location = touches.first?.location(in: parent) else {
            return
        }
        if self.contains(location) {
            press()
        }
        self.lastLocation = location
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let parent = self.parent else {
            return
        }
        guard let current = touches.first?.location(in: parent) else {
            return
        }

        if let previous = lastLocation {
            switch (contains(current), contains(previous)) {
            case (true, true):
                pressDragInside()

            case (true, false):
                pressDragEnter()

            case (false, true):
                pressDragExit()

            case (false, false):
                pressDragOutside()
            }
        }
        self.lastLocation = current
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let parent = self.parent else {
            return
        }
        guard let location = touches.first?.location(in: parent) else {
            return
        }
        if self.contains(location) {
            releaseInside()
        } else {
            releaseOutside()
        }
        self.lastLocation = nil
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    #endif
}
