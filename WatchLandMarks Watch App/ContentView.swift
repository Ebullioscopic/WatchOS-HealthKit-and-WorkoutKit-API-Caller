////
////  ContentView.swift
////  WatchLandMarks Watch App
////
////  Created by hariharan on 18/08/24.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
// ContentView.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var healthDataManager: HealthDataManager
//    @EnvironmentObject var networkManager: NetworkManager
//
//    @State private var isTracking = false
//    @State private var qrCodeImage: UIImage? = nil
//
//    var body: some View {
//        VStack {
//            if let qrCode = qrCodeImage {
//                Image(uiImage: qrCode)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 150, height: 150)
//                    .padding()
//            } else {
//                Text("Fetching QR Code...")
//                    .onAppear {
//                        networkManager.fetchQRCode { image in
//                            self.qrCodeImage = image
//                        }
//                    }
//            }
//
//            Button(action: {
//                if isTracking {
//                    healthDataManager.stopTracking()
//                    networkManager.sendHealthData(healthDataManager.collectedData)
//                } else {
//                    healthDataManager.startTracking()
//                }
//                isTracking.toggle()
//            }) {
//                Text(isTracking ? "Stop Tracking & Send Data" : "Start Tracking")
//                    .padding()
//            }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
/////////////////////////////////////////////////////
// ContentView.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

// ContentView.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthDataManager: HealthDataManager
    @EnvironmentObject var networkManager: NetworkManager

    @State private var isTracking = false
    @State private var qrCodeImage: UIImage? = nil

    var body: some View {
        VStack {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                // In Preview mode, show placeholder content
                Text("Preview Mode - QR Code")
                    .font(.headline)
                Image(systemName: "qrcode")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding()
            } else {
                // Normal mode (running on the device)
                if let qrCode = qrCodeImage {
                    Image(uiImage: qrCode)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .padding()
                } else {
                    Text("Fetching QR Code...")
                        .onAppear {
                            networkManager.fetchQRCode { image in
                                self.qrCodeImage = image
                            }
                        }
                }

                Button(action: {
                    if isTracking {
                        healthDataManager.stopTracking()
                        networkManager.sendHealthData(healthDataManager.collectedData)
                    } else {
                        healthDataManager.startTracking()
                    }
                    isTracking.toggle()
                }) {
                    Text(isTracking ? "Stop Tracking & Send Data" : "Start Tracking")
                        .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(HealthDataManager())
        .environmentObject(NetworkManager())
}
