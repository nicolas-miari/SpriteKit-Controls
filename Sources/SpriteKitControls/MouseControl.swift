//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/27.
//
import SpriteKit

#if os(macOS)

open class Control: SKSpriteNode {
    public var soundHandler: ControlSoundHandler?

    public enum State {
        /**
         The default, 'ready' state.
         */
        case normal

        /**
         The 'mouse-over' state.
         */
        case highlighted

        /**
         The 'clicked' or 'activated' state.
         */
        case selected

        /**
         The 'grayed', unresponsive state.
         */
        case disabled
    }

    public enum Event {
        case mouseEnter
        case mouseExit
        case mouseDown
        case mouseDragInside
        case mouseDragExit
        case mouseDragOutside
        case mouseDragEnter
        case mouseUpInside
        case mouseUpOutside
    }

    public typealias Handler = (() -> Void)

    private var handlers: [Event: [Handler]] = [:]
    private var backgroundTextures: [State: SKTexture] = [:]

    public var state: State = .normal {
        didSet {
            if let texture = backgroundTextures[state] ?? backgroundTextures[.normal] {
                self.texture = texture
                self.size = texture.size()
            }
            self.isUserInteractionEnabled = (state != .disabled)
        }
    }

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
    open func mouseEntered() {
        handleMouseEvent(.mouseEnter)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseExited() {
        handleMouseEvent(.mouseExit)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseDown() {
        handleMouseEvent(.mouseDown)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseDragInside() {
        handleMouseEvent(.mouseDragInside)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseDragExit() {
        handleMouseEvent(.mouseDragExit)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseDragOutside() {
        handleMouseEvent(.mouseDragOutside)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseDragEnter() {
        handleMouseEvent(.mouseDragEnter)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseUpInside() {
        handleMouseEvent(.mouseUpInside)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func mouseUpOutside() {
        handleMouseEvent(.mouseUpOutside)
    }

    private func handleMouseEvent(_ event: Event) {
        soundHandler?.playSound(for: event, of: self)
        handlers[event]?.forEach { $0() }
    }

    // MARK: - NSResponder

    override open func mouseDown(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }

        let location = event.location(in: self.parent!)

        guard self.contains(location) else {
            return
        }
        mouseDown()
    }

    override open func mouseEntered(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        mouseEntered()
    }

    override open func mouseExited(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        mouseExited()
    }

    override open func mouseDragged(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }

        let location = event.location(in: self.parent!)
        if self.contains(location) {
            mouseDragInside()
        } else {
            mouseDragOutside()
        }
    }

    override open func mouseUp(with event: NSEvent) {
        guard isUserInteractionEnabled else { return }
        let location = event.location(in: self.parent!)
        if self.contains(location) {
            mouseUpInside()
        } else {
            mouseUpOutside()
        }
    }
}

#endif
