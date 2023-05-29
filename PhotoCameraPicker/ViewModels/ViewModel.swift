//
//  ViewModel.swift
//  PhotoCameraPicker
//
//  Created by Eric on 27/05/2023.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: Picker.CameraErrorType?
    @Published var imageName: String = ""
    @Published var isEditing = false
    @Published var selectedImage: MyImage?
    
    var buttonDisabled: Bool {
        imageName.isEmpty || image == nil
    }
    
    var deleteButtonIsHidden: Bool {
        isEditing || selectedImage == nil
    }
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try Picker.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = Picker.CameraErrorType(error: error as! Picker.PickerError)
        }
    }
}
