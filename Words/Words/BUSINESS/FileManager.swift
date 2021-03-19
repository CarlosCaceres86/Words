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
    // MARK: Internal
    var originalWordsCounted: [WordCounted] = []
    var wordsCounted: [WordCounted] = []
    var totalWords: Int
    // MARK: Private
    private var originalWords: [String]
    private var originalWordsDict: [String:Int] = [:]

    // MARK: Init
    init(fileContent: String) {
        self.originalWords =  fileContent.words
        self.totalWords = self.originalWords.count
        self.initWordRepetitions()
    }

    // MARK: Functions
    // MARK: Internal
    func sortWords(by type: SortType) -> [WordCounted] {
        switch type {
            case .alphabetical: return sortAlphabeticaly()
            case .repetitions: return sortByRepetitions()
        }
    }

    // MARK: Private
    private func initWordRepetitions() {
        self.originalWordsDict = [String : Int]()
        self.originalWords.forEach { word in
            self.originalWordsDict[word.sanitized] = (self.originalWordsDict[word.sanitized] ?? 0) + 1
        }

        self.wordsCounted.append(contentsOf: self.originalWordsDict.map{ WordCounted(word: $0.key, count: $0.value) })
        self.originalWordsCounted.append(contentsOf: self.wordsCounted)

        #if DEBUG
//            print("ORIGINAL WORDS ---------------")
//            print(self.originalWords)
//            print("\nWORDS ------------------------")
//            print(self.wordsCounted)
        #endif
    }

    private func sortAlphabeticaly() -> [WordCounted] {
        return self.originalWordsDict.sorted(by: { $0.0 < $1.0 }).map { WordCounted(word: $0.key, count: $0.value) }
    }

    private func sortByRepetitions() -> [WordCounted] {
        return self.originalWordsDict.sorted(by: { $0.1 < $1.1 }).map { WordCounted(word: $0.key, count: $0.value) }
    }

} // FileManager

enum SortType {
    case alphabetical
    case repetitions
}
