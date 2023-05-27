//
//  Picker.swift
//  PhotoCameraPicker
//
//  Created by Eric on 27/05/2023.
//

import UIKit
import AVFoundation

enum Picker {
    enum Source: String {
        case library, camera
    }
    
    enum PickerError: Error, LocalizedError {
        case unavailable
        case restricted
        case denied
        
        var errorDescription: String? {
            switch self {
            case .unavailable:
                return NSLocalizedString("There is no availaible camera on this device", comment: "")
            case .restricted:
                return NSLocalizedString("You are not allowed to access media capture devices.", comment: "")
            case .denied:
                return NSLocalizedString("You have explicitly denied permission for media caputre. Please open permissions/Privacy/Camera and grand access for this application", comment: "")
            }
        }
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}
