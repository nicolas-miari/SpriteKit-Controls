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

        let button = Button(color: .red, size: CGSize(width: 200, height: 50))
        button.setBackgroundTexture(atlas.textureNamed("ButtonNormal"), for: .normal)
        button.setBackgroundTexture(atlas.textureNamed("ButtonMouseOver"), for: .highlighted)
        button.setBackgroundTexture(atlas.textureNamed("ButtonMouseDown"), for: .selected)
        button.setBackgroundTexture(atlas.textureNamed("ButtonDisabled"), for: .disabled)
        button.addHandler {
            button.state = .disabled
        }
        self.addChild(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
