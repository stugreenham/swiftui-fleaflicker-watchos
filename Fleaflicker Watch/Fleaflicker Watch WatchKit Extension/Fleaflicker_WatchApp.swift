//
//  Fleaflicker_WatchApp.swift
//  Fleaflicker Watch WatchKit Extension
//
//  Created by Stu Greenham on 24/05/2021.
//

import SwiftUI

@main
struct Fleaflicker_WatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
