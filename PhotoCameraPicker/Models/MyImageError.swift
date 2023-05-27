//
//  MyImageError.swift
//  PhotoCameraPicker
//
//  Created by Eric on 27/05/2023.
//

import SwiftUI

enum MyImageError: Error, LocalizedError {
case readError
case decodingError
case encodingError
case saveError
    
    var errorDescription: String? {
        switch self {
        case.readError:
            return NSLocalizedString("Could not load MyImage.json, please reinstall the app", comment: "")
        case .decodingError:
            return NSLocalizedString("There was a problem loading your list of imagesm please create a mew image to start overl.", comment: "")
        case .encodingError:
            return NSLocalizedString("Could not save your MyImage data, plese reinstall the app", comment: "")
        case .saveError:
            return NSLocalizedString("Could not save My Image json file. Please reinstall the app.", comment: "")
        }
    }
    
    struct ErrorType: Identifiable {
        let id = UUID()
        let error: MyImageError
        var message: String {
            error.localizedDescription
        }
        let button = Button("OK", role: .cancel) {}
    }
}
