//
//  AppDelegate.swift
//  SalahApp
//
//  Created by Faruk Turgut on 11.11.2019.
//  Copyright © 2019 Faruk Turgut. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var windowController: NSWindowController!
    let statusItem : NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        window = NSWindow(
            contentRect: NSRect(origin: .zero, size: .zero),
        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
        backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: SettingsView())
        windowController = NSWindowController()
        windowController.contentViewController = window.contentViewController
        windowController.window = window
        
        
        let mainMenu = NSMenu()
        
        let contentView = NSHostingController(rootView: PrayerView())
        contentView.view.frame = NSRect(x: 0, y: 0, width: 200, height: 50)
        let prayerView = NSMenuItem()
        prayerView.view = contentView.view
        
        let seperator = NSMenuItem.separator()
        let settings = NSMenuItem(title: "Settings", action: #selector(openSettings(_:)), keyEquivalent: "S")
        let quitAction = NSMenuItem(title: "Quit", action: #selector(quitApplication(_:)), keyEquivalent: "Q")
        
        mainMenu.addItem(prayerView)
        mainMenu.addItem(settings)
        mainMenu.addItem(seperator)
        mainMenu.addItem(quitAction)

        
        statusItem.button?.title = "App"
        statusItem.menu = mainMenu
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc private func openSettings(_ sender: NSMenuItem) {
        windowController.showWindow(self)
        
    }
 
    @objc private func quitApplication(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }

}

