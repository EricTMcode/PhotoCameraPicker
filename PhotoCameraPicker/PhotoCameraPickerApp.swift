//
//  PhotoCameraPickerApp.swift
//  PhotoCameraPicker
//
//  Created by Eric on 27/05/2023.
//

import SwiftUI

@main
struct PhotoCameraPickerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
