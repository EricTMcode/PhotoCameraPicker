//
//  MyImage.swift
//  PhotoCameraPicker
//
//  Created by Eric on 27/05/2023.
//

import UIKit

struct MyImage: Codable, Identifiable {
    var id = UUID()
    var name: String
    
    var image: UIImage {
        do {
            return try FileManager().readImage(with: id)
        } catch {
            return UIImage(systemName: "photo.fill")!
        }
    }
}
