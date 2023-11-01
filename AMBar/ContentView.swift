//
//  ContentView.swift
//  AMBar
//
//  Created by xizi on 2023/11/1.
//

import SwiftUI
import MusicKit
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}


#Preview {
    ContentView()
}


class AppDelegate: NSObject, NSApplicationDelegate {
    var next: NSStatusItem?
    var previous: NSStatusItem?
    var pause: NSStatusItem?
    
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        next = NSStatusBar.system.statusItem(withLength: 10)
        next?.button?.title = ">"
        next?.button?.action = #selector(nextEvent)
        
        pause = NSStatusBar.system.statusItem(withLength: 10)
        pause?.button?.title = "="
        pause?.button?.action = #selector(playpauseEvent)
        
        previous = NSStatusBar.system.statusItem(withLength: 10)
        previous?.button?.title = "<"
        previous?.button?.action = #selector(previousEvent)

        

        // 创建状态栏图标
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = ApiManager().currentTrack().name ?? ""
        if let statusItem = statusItem {
//            statusItem.button?.title = "🚀"
            
            // 创建菜单项
            let menu = NSMenu()
//            menu.addItem(withTitle: "选项1", action: #selector(menuItemClicked(_:)), keyEquivalent: "")
//            menu.addItem(withTitle: "选项2", action: #selector(menuItemClicked(_:)), keyEquivalent: "")
            menu.addItem(NSMenuItem.separator())
            menu.addItem(withTitle: "退出", action: #selector(quit(_:)), keyEquivalent: "q")
            
            statusItem.menu = menu
        }
        permission()
        
        let nc = DistributedNotificationCenter.default()
        nc.addObserver(self, selector: #selector(trackChanged), name: NSNotification.Name(rawValue: "com.apple.Music.playerInfo"), object: nil)
    
    }
    
    deinit {
        DistributedNotificationCenter.default().removeObserver(self)
    }
    
    @objc func trackChanged(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            print(userInfo["Name"])
        
            statusItem?.button?.title = userInfo["Name"] as? String ?? ""
        }
    }
    
    func permission() {
        Task {
            print(MusicAuthorization.currentStatus)
//            await Manager.getMusic()
            if MusicAuthorization.currentStatus != .authorized {
                await MusicAuthorization.request()
            }
            print(MusicAuthorization.currentStatus)
        }
    }
    
    @objc func previousEvent() {
        ApiManager().prev()
        
    }
    
    @objc func nextEvent() {
        ApiManager().next()
    }
    
    @objc func playpauseEvent() {
        ApiManager().playpause()
    }
    
    @objc func menuItemClicked(_ sender: NSMenuItem) {
        if sender.title == "选项1" {
            // 处理选项1的点击事件
            print("选项1被点击了")
        } else if sender.title == "选项2" {
            // 处理选项2的点击事件
            print("选项2被点击了")
        }
    }
    
    @objc func quit(_ sender: Any?) {
        NSApplication.shared.terminate(self)
    }
}
