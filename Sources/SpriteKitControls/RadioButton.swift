//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/28.
//

import SpriteKit

open class RadioButton: Control {

    private(set) var group: RadioGroup?

    /**
     Executed every time the button state changes from `.normal` to `.selected`.
     */
    public var selectHandler: (() -> Void)?

    // MARK: - Operation

    /**
     Buttons retain the group they belong to. The group only has weak
     references. This way, you don't need to keep a reference to the group (and
     the buttons themselves are kept alive by the node hierarchy).
     */
    public func addToGroup(_ group: RadioGroup) {
        if self.group != nil {
            removeFromGroup()
        }
        group.addButton(self)
        self.group = group
    }

    public func removeFromGroup() {
        group?.removeButton(self)
        self.group = nil
    }

    // MARK: - Intents

    override open func press() {
        switch state {
        case .normal:
            if let group = group {
                group.select(self)
            } else {
                self.state = .selected
            }
            selectHandler?()
        default:
            break
        }
        super.press()
    }
}

// MARK: - Support

public class RadioGroup {

    private var buttonReferences: [WeakReference<RadioButton>]

    public init() {
        self.buttonReferences = []
    }

    public func addButton(_ button: RadioButton) {
        if buttonReferences.contains(where: { (weakReference) -> Bool in
            return weakReference.object === button
        }) {
            return
        }
        buttonReferences.append(WeakReference(button))
    }

    public func removeButton(_ button: RadioButton) {
        guard let index = buttonReferences.firstIndex (where: {
            $0.object === button
        }) else {
            return
        }
        buttonReferences.remove(at: index)
    }

    public func select(_ selectedButton: RadioButton) {
        buttonReferences.forEach { (reference) in
            guard let button = reference.object else {
                return
            }
            if button === selectedButton {
                button.state = .selected
            } else {
                button.state = .normal
            }
        }
    }
}

private struct WeakReference<Type: AnyObject> {
    weak var object: Type?

    init(_ object: Type) {
        self.object = object
    }
}


