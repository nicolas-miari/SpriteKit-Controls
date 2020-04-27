# SpriteKit Controls
Reusable GUI components (a.k.a. _controls_) for touch-based (iOS) and mouse-based (macOS) **SpriteKit** projects.

## Overall Design

The classes, while being SpriteKit **node subclasses**, should in principle mirror those in UIKit/AppKit (UIControl/NSControl, UIButton/NSButton), _minus_ all the Cocoa/Objective-C-specific baggage (e.g., target-action, KVO, etc.) and adopt a more swifty design.

## Class Hierarchy

### Control

Subclasses SKSpriteNode and implements essential control logic: state, event handler registration, background texture/color per state. The implementation has platform-specific sections.

### Button

Subclasses Control, implements:
1. Button-specific logic - state transitions driven by touch/mouse events, consistent with 
button-like behavior (select on touch-down, etc.)
2. Button-specific appearance - configurable title label. 

### To Do

Add more Control subclasses in the future (e.g., switch, slider, etc.).


## Sample Project

The included sample project `Example/Example.xcodeproj` demonstrates the basic use of the Button control on both iOS and macOS SpriteKit apps.
