////
////  NetworkManager.swift
////  WatchLandMarks Watch App
////
////  Created by hariharan on 25/08/24.
////
//
//import Foundation
// NetworkManager.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

// NetworkManager.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

import Foundation
import UIKit
import SwiftUI

class NetworkManager: ObservableObject {
    private let serverURL = "https://your-django-backend.com/api"
    
    func fetchQRCode(completion: @escaping (UIImage?) -> Void) {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            completion(nil) // Don't perform network requests during preview
            return
        }
        #endif

        guard let url = URL(string: "\(serverURL)/get-qr-code/") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                print("Failed to fetch QR code: \(error?.localizedDescription ?? "No error")")
                completion(nil)
            }
        }.resume()
    }

    func sendHealthData(_ data: [String: Any]) {
        guard let url = URL(string: "\(serverURL)/post-health-data/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        } catch {
            print("Failed to serialize health data to JSON: \(error.localizedDescription)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to send health data: \(error.localizedDescription)")
            } else {
                print("Health data sent successfully.")
            }
        }.resume()
    }
}
