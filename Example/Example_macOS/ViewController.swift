//
//  ViewController.swift
//  Example_macOS
//
//  Created by Nicolás Miari on 2020/04/27.
//  Copyright © 2020 Nicolás Miari. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear() {
        super.viewWillAppear()

        let scene = TestScene(size: view.bounds.size)
        guard let skView = self.view as? SKView else {
            fatalError("Storyboard inconsistency")
        }
        skView.presentScene(scene)
    }
}

