//
//  File.swift
//  
//
//  Created by Nicolás Miari on 2020/04/28.
//

import SpriteKit

open class Switch: Control {

    override open func press() {
        switch state {
        case .normal:
            self.state = .selected

        default:
            break
        }
        super.press()
    }

    override open func releaseInside() {
        switch state {
        case .selected:
            self.state = .normal

        default:
            break
        }
        super.releaseInside()
    }
}
