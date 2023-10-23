//
//  StubLoader.swift
//  NYTimesTests
//
//  Created by Syed Zainulabideen on 23/10/2023.
//

import Foundation

struct StubLoader {
    let fileName: String
    let fileExtension: String

    init(fileName: String, fileExtension: String = "json") {
        self.fileName = fileName
        self.fileExtension = fileExtension
    }

    func loadJSONData<T: Codable>() -> T? {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("File not found: \(fileName).\(fileExtension)")
            return nil
        }

        do {
            let jsonData = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: jsonData)
            return decodedObject
        } catch {
            print("Error loading JSON data: \(error)")
            return nil
        }
    }
}
