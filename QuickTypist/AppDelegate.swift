//
//  AppDelegate.swift
//  QuickTypist
//
//  Created by Mikael Hallendal on 06/01/15.
//  Copyright (c) 2015 Mikael Hallendal. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let typeViewController = TypeViewController("This is some text that we should show the user whatever that might be it should be typed fast".componentsSeparatedByString(" "))

        self.window.contentViewController = typeViewController
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

