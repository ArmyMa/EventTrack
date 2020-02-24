//
//  UIViewController-Extension.swift
//  zzzj
//
//  Created by Army_Ma on 2018/5/16.
//  Copyright © 2018年 Army_Ma. All rights reserved.
//

import UIKit


extension UIViewController : SwizzlingProtocol{
    
    @objc static func awake() {
        swizzleWillAppearMethod
        swizzleWillDisAppearMethod
        swizzleDidLoadMethod
    }
    private static let swizzleWillAppearMethod: Void = {
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(new_viewWillAppear(_:))
        swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc func new_viewWillAppear(_ animated: Bool) {
        new_viewWillAppear(animated)
        print("\(type(of: self)) ----- EventTrackSDK new_viewWillAppear")
    }

    
    private static let swizzleWillDisAppearMethod: Void = {
           let originalSelector = #selector(viewWillDisappear(_:))
           let swizzledSelector = #selector(new_viewWillDisAppear(_:))
           swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)

       }()
       
    @objc func new_viewWillDisAppear(_ animated: Bool) {
        new_viewWillDisAppear(animated)
        print("\(type(of: self)) ----- EventTrackSDK new_viewWillDisAppear")
    }
    
    private static let swizzleDidLoadMethod: Void = {
        let originalSelector = #selector(viewDidLoad)
        let swizzledSelector = #selector(new_viewDidLoad)
        swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)

    }()
    
    @objc func new_viewDidLoad() {
        new_viewDidLoad()
        print("\(type(of: self)) ----- EventTrackSDK new_viewDidLoad")
    }
    
   
}

