//
//  ViewController.swift
//  Example_macOS
//
//  Created by Nicolás Miari on 2020/04/27.
//  Copyright © 2020 Nicolás Miari. All rights reserved.
//

import SpriteKit

class ViewController: NSViewController {

    /**
     On macOS, instead of using/subclassing SKView directly, use/subclass the
     provided **TrackingView**. This class is itself a subclass of SKView which
     (unlike NSView and SKView) is set up from the get-go to receive the
     `mouseMoved(with:)` event, essential for `Button` controls to function
     properly.
     */
    @IBOutlet var skView: TrackingView!

    // MARK: - NSViewController

    override func viewWillAppear() {
        super.viewWillAppear()

        let scene = TestScene(size: view.bounds.size)
        guard let skView = self.view as? SKView else {
            fatalError("Storyboard inconsistency")
        }
        skView.presentScene(scene)
    }
}
