//
//  TestScene.swift
//  Example_macOS
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

        let button1 = Button(normalTexture: atlas.textureNamed("ButtonNormal"))
        button1.setBackgroundTexture(atlas.textureNamed("ButtonMouseOver"), for: .highlighted)
        button1.setBackgroundTexture(atlas.textureNamed("ButtonMouseDown"), for: .selected)
        button1.setBackgroundTexture(atlas.textureNamed("ButtonDisabled"), for: .disabled)
        button1.addHandler {
            button1.state = .disabled
        }
        self.addChild(button1)
        button1.position = CGPoint(x: 0, y: 10)

        let button2 = Button(normalTexture: atlas.textureNamed("ButtonNormal"))
        button2.setBackgroundTexture(atlas.textureNamed("ButtonMouseOver"), for: .highlighted)
        button2.setBackgroundTexture(atlas.textureNamed("ButtonMouseDown"), for: .selected)
        button2.setBackgroundTexture(atlas.textureNamed("ButtonDisabled"), for: .disabled)
        button2.addHandler {
            button2.state = .disabled
        }
        self.addChild(button2)
        button2.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        button2.position = CGPoint(x: 0, y: -100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
