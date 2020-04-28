//
//  TestScene.swift
//  Example
//
//  Created by Nicolás Miari on 2020/04/27.
//  Copyright © 2020 Nicolás Miari. All rights reserved.
//

import SpriteKit
import SpriteKitControls

class TestScene: SKScene {

    override init(size: CGSize) {
        super.init(size: size)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let atlas = SKTextureAtlas(named: "Buttons")
        let button = Button(normalTexture: atlas.textureNamed("ButtonNormal"))
        button.setBackgroundTexture(atlas.textureNamed("ButtonHighlighted"), for: .selected)
        button.setBackgroundTexture(atlas.textureNamed("ButtonDisabled"), for: .disabled)

        button.addHandler({
            print("Down!")
        }, for: .press)

        button.addHandler({
            print("Drag Inside!")
        }, for: .pressDragInside)

        button.addHandler({
            print("Drag Exit!")
        }, for: .pressDragExit)

        button.addHandler({
            print("Drag Outside!")
        }, for: .pressDragOutside)

        button.addHandler({
            print("Up Outside")
        }, for: .releaseOutside)

        button.addHandler({
            print("Drag Enter!")
        }, for: .pressDragEnter)

        button.addHandler({
            print("Up Inside!")
            button.state = .disabled
        }, for: .releaseInside)

        self.addChild(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
