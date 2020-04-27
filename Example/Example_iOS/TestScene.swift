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
        button.setBackgroundTexture(atlas.textureNamed("ButtonHighlighted"), for: .highlighted)
        button.setBackgroundTexture(atlas.textureNamed("ButtonDisabled"), for: .disabled)

        button.addHandler({
            print("Down!")
        }, for: .touchDown)

        button.addHandler({
            print("Drag Inside!")
        }, for: .touchDragInside)

        button.addHandler({
            print("Drag Exit!")
        }, for: .touchDragExit)

        button.addHandler({
            print("Drag Outside!")
        }, for: .touchDragOutside)

        button.addHandler({
            print("Up Outside")
        }, for: .touchUpOutside)

        button.addHandler({
            print("Drag Enter!")
        }, for: .touchDragEnter)

        button.addHandler({
            print("Up Inside!")
            button.state = .disabled

        }, for: .touchUpInside)

        self.addChild(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
