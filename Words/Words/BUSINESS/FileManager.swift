//
//  FileModel.swift
//  Words
//
//  Created by Carlos Cáceres González on 18/03/2021.
//

import Foundation

typealias WordCounted = (word: String, count: Int)

class FileManager {

    // MARK: Properties
    var originalWords: [String]
    var words: [WordCounted] = []
    var totalWords: Int

    // MARK: Init
    init(fileContent: String) {
        self.originalWords =  fileContent.words
        self.totalWords = self.originalWords.count
        self.initWordRepetitions()
    }

    // MARK: Functions
    private func initWordRepetitions() {
        var wordsDict = [String : Int]()

        self.originalWords.forEach { word in
            wordsDict[word.sanitized] = (wordsDict[word.sanitized] ?? 0) + 1
        }

        self.words.append(contentsOf: wordsDict.map{ WordCounted(word: $0.key, count: $0.value) })

        #if DEBUG
            print("ORIGINAL WORDS ---------------")
            print(self.originalWords)
            print("\nWORDS ------------------------")
            print(self.words)
        #endif
    }

} // FileManager
