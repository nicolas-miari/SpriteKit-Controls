# SpriteKit-Touch-Controls
Reusable UI components for touch-based (iOS) SpriteKit projects.

## Overall Design

The classes should in principle mirror those in UIKit (UIControl, UIButton), _minus_ all the 
Cocoa/Objective-C-specific baggage (e.g., target-action, KVO, etc.) and adopt a more
swifty design.

## Class Hierarchy

### Control

Subclasses SKSpriteNode and implements essential control logic: state, event handler 
registration, background texture/color per state.

### Button

Subclasses Control, implements:
  1. Button-specific logic - state transitions driven by touch
events that are consistent with button-like behavior (select on touch-down, etc.)
  2. Button-specific appearance - configurable title label. 

### To Do

Add more Control subclasses in the future (e.g., switch, slider, etc.).


## Sample Project

Read [this](https://github.com/bscothern/ExampleAppForSwiftPackage).
