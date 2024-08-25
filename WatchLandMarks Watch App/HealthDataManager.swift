////
////  HealthDataManager.swift
////  WatchLandMarks Watch App
////
////  Created by hariharan on 25/08/24.
////
//
//import Foundation
// HealthDataManager.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

// HealthDataManager.swift
// WatchLandMarks Watch App
//
// Created by hariharan on 18/08/24.
//

import Foundation
import HealthKit
import Combine

class HealthDataManager: ObservableObject {
    private var healthStore: HKHealthStore?
    private var workoutSession: HKWorkoutSession?
    private var workoutBuilder: HKLiveWorkoutBuilder?
    @Published var collectedData: [String: Any] = [:]

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            requestAuthorization()
        } else {
            print("HealthKit is not available on this device.")
        }
    }

    private func requestAuthorization() {
        guard let healthStore = healthStore else { return }

        let healthDataToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: healthDataToRead) { success, error in
            if !success {
                print("HealthKit Authorization Failed: \(error?.localizedDescription ?? "No error")")
            }
        }
    }

    func startTracking() {
        guard let healthStore = healthStore else { return }

        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor

        do {
            workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            workoutBuilder = workoutSession?.associatedWorkoutBuilder()
            workoutBuilder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)

            workoutBuilder?.beginCollection(withStart: Date(), completion: { (success, error) in
                if !success {
                    print("Failed to start collection: \(error?.localizedDescription ?? "No error")")
                }
            })

            workoutSession?.startActivity(with: Date())
        } catch {
            print("Error starting workout session: \(error.localizedDescription)")
        }
    }

    func stopTracking() {
        workoutSession?.end()
        workoutBuilder?.endCollection(withEnd: Date()) { (success, error) in
            self.workoutBuilder?.finishWorkout { (workout, error) in
                self.collectHealthData(workout: workout)
            }
        }
    }

    private func collectHealthData(workout: HKWorkout?) {
        // Assuming data is collected in a dictionary format
        collectedData["heartRate"] = [/* Retrieved heart rate data */]
        collectedData["steps"] = [/* Retrieved step data */]
    }
}
