//
//  FileModel.swift
//  Words
//
//  Created by Carlos Cáceres González on 18/03/2021.
//

import Foundation

class FileManager {

    // MARK: Properties
    var originalWords: [String]
    var words: [String : Int] = [String : Int]()
    var totalWords: Int

    // MARK: Init
    init(fileContent: String) {
        self.originalWords =  fileContent.words
        self.totalWords = self.originalWords.count
        self.initWordRepetitions()
    }

    // MARK: Functions
    private func initWordRepetitions() {
        self.originalWords.forEach { word in
            self.words[word.sanitized] = (self.words[word.sanitized] ?? 0) + 1
        }

        #if DEBUG
            print("ORIGINAL WORDS ---------------")
            print(self.originalWords)
            print("\nWORDS ------------------------")
            print(self.words)
        #endif
    }

} // FileManager
