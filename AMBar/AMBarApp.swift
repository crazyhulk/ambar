//
//  AMBarApp.swift
//  AMBar
//
//  Created by xizi on 2023/11/1.
//

import SwiftUI

@main
struct AMBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
//        WindowGroup {
//            EmptyView()
////            ContentView()
//        }
        Settings {
            ContentView()
        }
    }
}
