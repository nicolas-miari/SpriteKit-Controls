import SpriteKit

/**
 SKSpriteNode subclass that implements the most basic, common UI control
 behavior. All concrete controls should subclass this.
 */
#if os(iOS)
open class Control: SKSpriteNode {

    public var soundHandler: ControlSoundHandler? 

    public enum State {
        /**
         The default, 'ready' state.
         */
        case normal

        /**
         The 'touch-down' state.
         */
        case highlighted

        /**
         The 'grayed', unresponsive state.
         */
        case disabled
    }

    public enum Event {
        case touchDown
        case touchDragInside
        case touchDragExit
        case touchDragOutside
        case touchUpOutside
        case touchDragEnter
        case touchUpInside
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
    open func touchDown() {
        handleTouchEvent(.touchDown)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func touchDragInside() {
        handleTouchEvent(.touchDragInside)
    }

    /// Subclsses can override an@objc d manipulate the value of `state` accordingly.
    open func touchDragExit() {
        handleTouchEvent(.touchDragExit)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func touchDragOutside() {
        handleTouchEvent(.touchDragOutside)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func touchDragEnter() {
        handleTouchEvent(.touchDragEnter)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func touchUpInside() {
        handleTouchEvent(.touchUpInside)
    }

    /// Subclsses can override and manipulate the value of `state` accordingly.
    open func touchUpOutside() {
        handleTouchEvent(.touchUpOutside)
    }

    private func handleTouchEvent(_ event: Event) {
        soundHandler?.playSound(for: event, of: self)
        handlers[event]?.forEach { $0() }
    }

    // MARK: - UIResponder

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.parent!) else {
            return
        }
        if self.contains(location) {
            touchDown()
        }
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let current = touch.location(in: self)
        let previous = touch.previousLocation(in: self)

        switch (contains(current), contains(previous)) {
        case (true, true):
            touchDragInside()

        case (true, false):
            touchDragEnter()

        case (false, true):
            touchDragExit()

        case (false, false):
            touchDragOutside()
        }
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.parent!) else {
            return
        }
        if self.contains(location) {
            touchUpInside()
        } else {
            touchUpOutside()
        }
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}
#endif
