//
//  AppGroupUserDefaults.swift
//  NJTransit
//
//  Created by Angelo Walczak on 08.10.23.
//

import Foundation

enum AppGroupUserDefaults {
    static let shared = UserDefaults(suiteName: "group.com.NJTransitApp")!
    
    enum StorageKey {
        static let travelFrom = "travelFrom"
        static let travelTo = "travelTo"
        static let boardingTime = "boardingTime"
    }
}
