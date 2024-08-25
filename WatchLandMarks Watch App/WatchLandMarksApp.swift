////
////  WatchLandMarksApp.swift
////  WatchLandMarks Watch App
////
////  Created by hariharan on 18/08/24.
////
//
//import SwiftUI
//
//@main
//struct WatchLandMarks_Watch_AppApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
// WatchLandMarksApp.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

import SwiftUI

@main
struct WatchLandMarks_Watch_AppApp: App {
    @StateObject private var healthDataManager = HealthDataManager()
    @StateObject private var networkManager = NetworkManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthDataManager)
                .environmentObject(networkManager)
        }
    }
}
