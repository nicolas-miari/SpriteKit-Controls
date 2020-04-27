//
//  ControlSoundHandler.swift
//  
//
//  Created by Nicolás Miari on 2020/04/27.
//

import Foundation

/**
 Objects of type adopting this protocol can register themselves to be notified
 of control events and play sounds accordingly
 */
public protocol ControlSoundHandler: AnyObject {

    /**
     When `event` occurs, `control` will notify the registered control sound
     handler by calling this method.
     */
    func playSound(for event: Control.Event, of control: Control)
}
