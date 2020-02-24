//
//  UITableView-Track.swift
//  EventTrackSDK
//
//  Created by Army_Ma on 2020/2/21.
//  Copyright © 2020 Army_Ma. All rights reserved.
//

import UIKit

extension UITableView : SwizzlingProtocol {
    static func awake() {
        swizzleButtonClickMethod
    }
    
    private static let swizzleButtonClickMethod: Void = {
//        let originalSelector = #selector(sendAction)
        let originalSelector = #selector(setter: UITableView.delegate)
        let swizzledSelector = #selector(UITableView.nsh_set(delegate:))
        
        swizzlingForClass(UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc public func nsh_set(delegate: UITableViewDelegate?){
           nsh_set(delegate: delegate)
           
           guard let delegate =  delegate else {return}
           print("UITableViewDelegate set delegate:\(delegate)")

        let originalSelector = #selector(delegate.tableView(_:didSelectRowAt:))
        let swizzledSelector = #selector(UITableView.nsh_tableView(_:didSelectRowAt:))
        let forClass = UITableView.self
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)

        let didAddMethod = class_addMethod(type(of: delegate), swizzledSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))

        if didAddMethod{
            let didSelectOriginalMethod = class_getInstanceMethod(type(of: delegate), NSSelectorFromString("nsh_tableView:didSelectRowAt:"))
            let didSelectSwizzledMethod = class_getInstanceMethod(type(of: delegate), originalSelector)
            method_exchangeImplementations(didSelectOriginalMethod!, didSelectSwizzledMethod!)
        }
        
    }
    
    @objc public func nsh_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nsh_tableView(tableView, didSelectRowAt: indexPath)
        print("UITableViewDelegate did selected")

    }
    
}
