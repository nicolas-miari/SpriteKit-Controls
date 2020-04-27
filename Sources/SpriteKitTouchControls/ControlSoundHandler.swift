//
//  ControlSoundHandler.swift
//  
//
//  Created by Nicolás Miari on 2020/04/27.
//

import Foundation

public protocol ControlSoundHandler: AnyObject {
    func playSound(for event: Control.Event, of control: Control)
}
