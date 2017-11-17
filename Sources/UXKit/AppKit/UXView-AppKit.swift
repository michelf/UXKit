//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa

  public typealias UXView             = NSView
  public typealias UXLabel            = NSTextField
  public typealias UXTextField        = NSTextField
  public typealias UXScrollView       = NSScrollView
  public typealias UXCollectionView   = NSCollectionView
  public typealias UXSearchField      = NSSearchField
  public typealias UXSpinner          = NSProgressIndicator
  public typealias UXProgressBar      = NSProgressIndicator
  public typealias UXButton           = NSButton
  public typealias UXTextView         = NSTextView
  public typealias UXPopUp            = NSPopUpButton
  public typealias UXStackView        = NSStackView
  public typealias UXCheckBox         = NSButton
  public typealias UXImageView        = NSImageView
  public typealias UXSlider           = NSSlider
  
  
  // MARK: - UXUserInterfaceItemIdentification

  #if os(macOS) && swift(>=4.0)
    public typealias UXUserInterfaceItemIdentifier =
                       NSUserInterfaceItemIdentifier
  #else
    public typealias UXUserInterfaceItemIdentifier = String
  #endif
  
  public typealias UXUserInterfaceItemIdentification =
                     NSUserInterfaceItemIdentification

  
  // MARK: - UIView Compatibility
  
  public extension NSView {
    
    /// Set the needsLayout property to true. Use this for UIKit compat.
    public final func setNeedsLayout() {
      needsLayout = true
    }
    
    /// Set the needsDisplay property to true. Use this for UIKit compat.
    /// Note: NSControl also has a setNeedsDisplay() function, presumably doing
    ///       the same.
    public final func setNeedsDisplay() {
      // This is ambiguous on macOS 10.12? NSControl also has setNeedsDisplay()
      needsDisplay = true
    }
    
    /// Set the needsUpdateConstraints property to true. Use this for UIKit compat.
    public final func setNeedsUpdateConstraints() {
      needsUpdateConstraints = true
    }
    
    public var center: CGPoint {
      // TODO: On UIKit this can be set, can we emulate this? (if layer based
      //       maybe?)
      return CGPoint(x: NSMidX(frame), y: NSMidY(frame))
    }
  }

  public extension NSProgressIndicator {
    // UIActivityIndicatorView has `isAnimating`, `startAnimation` etc.
    
    /// Use this instead of `start[stop]Animation` for UIKit compatibility.
    public var isSpinning : Bool {
      set {
        if newValue { startAnimation(nil) }
        else        { stopAnimation (nil) }
      }
      get {
        // this is hackish, requires: isDisplayedWhenStopped == false
        return !isHidden
      }
    }
    
  }
  
  /// Add UISwitch `isOn` property. The AppKit variant has 3 states.
  public extension NSButton {
    
    #if swift(>=4.0)
      /// Use this instead of `state` for UIKit compatibility.
      public var isOn: Bool {
        set { state = newValue ? .on : .off }
        get { return state == .on }
      }
    #else // Swift 3
      /// Use this instead of `state` for UIKit compatibility.
      public var isOn: Bool {
        set { state = newValue ? NSOnState : NSOffState }
        get { return state == NSOnState }
      }
    #endif
  }
  
  public extension NSTextField {
    
    /// Use this instead of `alignment` for UIKit compatibility.
    var textAlignment: NSTextAlignment {
      set { alignment = newValue }
      get { return alignment }
    }
    
  }
#endif // os(macOS)