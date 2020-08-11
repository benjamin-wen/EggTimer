//
//  AppDelegate.swift
//  EggTimer
//
//  Created by Zhishen Wen on 7/10/20.
//  Copyright © 2020 Benjamin Wen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var startTimerMenueItem: NSMenuItem!
    @IBOutlet weak var stopTimerMenueItem: NSMenuItem!
    @IBOutlet weak var resetTimerMenueItem: NSMenuItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        enableMenus(start: true, stop: false, reset: false)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func enableMenus(start: Bool, stop: Bool, reset: Bool) {
        startTimerMenueItem.isEnabled = start
        stopTimerMenueItem.isEnabled = stop
        resetTimerMenueItem.isEnabled = reset
    }
}

