//
//  MyImage.swift
//  PhotoCameraPicker
//
//  Created by Eric on 27/05/2023.
//

import Foundation

struct MyImage: Codable, Identifiable {
    var id = UUID()
    var name: String
}
