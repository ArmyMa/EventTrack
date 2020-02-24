//
//  UIButton-Track.swift
//  EventTrackSDK
//
//  Created by Army_Ma on 2020/2/8.
//  Copyright © 2020 Army_Ma. All rights reserved.
//

import UIKit

extension UIButton : SwizzlingProtocol {
    static func awake() {
        swizzleButtonClickMethod
    }
    
    private static let swizzleButtonClickMethod: Void = {
//        let originalSelector = #selector(sendAction)
        let originalSelector = #selector(sendAction(_:to:for:))
        let swizzledSelector = #selector(new_sendAction(action:to:forEvent:))
        
        swizzlingForClass(UIButton.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc public func new_sendAction(action: Selector, to: AnyObject!, forEvent: UIEvent!) {
       new_sendAction(action: action, to: to, forEvent: forEvent)
        print("\(self.title(for: .normal) ?? "UIButton") ++++ buttonClick")
    }
    
}

