//
//  SwizzlingTool.swift
//  EventTrackSDK
//
//  Created by Army_Ma on 2020/2/8.
//  Copyright © 2020 Army_Ma. All rights reserved.
//

import UIKit

protocol SwizzlingProtocol: class {
    static func awake()
    static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector)
}

extension SwizzlingProtocol {
    
     static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}

class SwizzlingTool {
    @objc static func searchAndExecuteAwake() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SwizzlingProtocol.Type)?.awake()
        }
        types.deallocate()
    }
}

extension UIApplication {
    private static let runOnce: Void = {
        print("\(type(of: self)) ----- EventTrackSDK next +++++++++")
        UIApplication.awake()
        SwizzlingTool.searchAndExecuteAwake()
    }()
    
    override open var next: UIResponder? {
        UIApplication.runOnce

        return super.next
    }
    
    
    
   
    
}

extension UIApplication :UIApplicationDelegate,SwizzlingProtocol  {
    static func awake() {
        swizzleWillAppearMethod1
    }
    
    
    
    @objc public func new_application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("\(type(of: self)) ----- EventTrackSDK new_application +++++++++")

        return new_application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
     private static let swizzleWillAppearMethod1: Void =  {
        let originalSelector = #selector(setter:UIApplication.shared.delegate)
        let swizzleSelector = #selector(UIApplication.nsh_set(delegate:))
        
//        let originalSelector = #selector(UIApplication.shared.delegate!.application(_:didFinishLaunchingWithOptions:))
//           let swizzledSelector = #selector(new_application(_:didFinishLaunchingWithOptions:))
//        swizzlingForClass(UIApplication.self, originalSelector: originalSelector, swizzledSelector: swizzleSelector)
        let didSelectOriginalMethod = class_getInstanceMethod(UIApplication.self, originalSelector)
        let didSelectSwizzledMethod = class_getInstanceMethod(UIApplication.self, swizzleSelector)
        method_exchangeImplementations(didSelectOriginalMethod!, didSelectSwizzledMethod!)
        
    }()
    
    @objc func nsh_set(delegate: UIApplicationDelegate?){
        nsh_set(delegate: delegate)
        
        guard let delegate =  delegate else {return}
        print("UIApplicationDelegate set delegate:\(delegate)")
        
    }
    
}
