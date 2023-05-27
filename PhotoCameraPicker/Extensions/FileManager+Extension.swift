//
//  FileManager+Extension.swift
//  MyToDos
//
//  Created by Stewart Lynch on 2021-04-07.
//

import UIKit

let fileName = "MyImages.json"

extension FileManager {
    static var docDirURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
    
    func saveDocument(contents: String) throws {
        let url = Self.docDirURL.appendingPathComponent(fileName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            throw MyImageError.saveError
        }
    }
    
    func readDocument() throws -> Data {
        let url = Self.docDirURL.appendingPathComponent(fileName)
        do {
            return try Data(contentsOf: url)
        } catch {
            throw MyImageError.readError
        }
    }
}
