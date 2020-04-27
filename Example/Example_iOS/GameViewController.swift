//
//  GameViewController.swift
//  Example
//
//  Created by Nicolás Miari on 2020/04/26.
//  Copyright © 2020 Nicolás Miari. All rights reserved.
//

import UIKit
import SpriteKit
//import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.isUserInteractionEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let scene = TestScene(size: view.bounds.size)
        guard let skView = self.view as? SKView else {
            fatalError("Storyboard inconsistency")
        }
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
