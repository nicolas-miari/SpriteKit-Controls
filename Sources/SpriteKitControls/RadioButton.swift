//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/28.
//

import SpriteKit

open class RadioButton: Control {

    private(set) weak var group: RadioGroup?

    // MARK: - Operation

    public func addToGroup(_ group: RadioGroup) {
        group.addButton(self)
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
        default:
            break
        }
        super.press()
    }
}

// MARK: - Support

public class RadioGroup {

    private(set) var buttons: [RadioButton]

    public init() {
        self.buttons = []
    }

    public func addButton(_ button: RadioButton) {
        if buttons.contains(button) {
            return
        }
        buttons.append(button)
    }

    public func select(_ selectedButton: RadioButton) {
        buttons.forEach { (button) in
            if button == selectedButton {
                button.state = .selected
            } else {
                button.state = .normal
            }
        }
    }
}


