//
//  FileLoader.swift
//  Words
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import Foundation

class FileLoader {

    // MARK: Functions
    // MARK: Internal
    func load(fileName: String) -> String? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") else { return nil }

        let fileContent = try? String(contentsOfFile: filePath)

        return fileContent
    }

} // FileLoader
