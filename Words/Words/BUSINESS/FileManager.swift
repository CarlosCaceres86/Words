//
//  FileModel.swift
//  Words
//
//  Created by Carlos Cáceres González on 18/03/2021.
//

import Foundation

typealias WordCounted = (word: String, count: Int)

/// Available sorting types
enum SortType {
    case alphabetical
    case repetitions
}

/// FileManager have a series of functionalities
/// to work with the current loaded file.
class FileManager {

    // MARK: Properties
    // MARK: Internal
    var wordsCounted: [WordCounted] = []
    var totalWords: Int
    // MARK: Private
    private var words: [String]
    private var wordsDict: [String:Int] = [:]

    // MARK: Init
    init(fileContent: String) {
        self.words =  fileContent.words
        self.totalWords = self.words.count
        self.initWordRepetitions()
    }

    // MARK: Functions
    // MARK: Internal

    /// To sort the word list depending
    /// on the selected sort type
    func sortWords(by type: SortType) -> [WordCounted] {
        switch type {
            case .alphabetical: return sortAlphabeticaly()
            case .repetitions: return sortByRepetitions()
        }
    }

    // MARK: Private
    private func initWordRepetitions() {
        // First get a dictionary with words and their repetitions.
        // Each word is sanitized to avoid differences with symbols an upper-lower cases.
        self.wordsDict = [String : Int]()
        self.words.forEach { word in
            self.wordsDict[word.sanitized] = (self.wordsDict[word.sanitized] ?? 0) + 1
        }

        // Convert the dictionary into a tupla to have a cleaner way to access the results
        self.wordsCounted.append(contentsOf: self.wordsDict.map{ WordCounted(word: $0.key, count: $0.value) })

        #if DEBUG
//            print("ORIGINAL WORDS ---------------")
//            print(self.originalWords)
//            print("\nWORDS ------------------------")
//            print(self.wordsCounted)
        #endif
    }

    private func sortAlphabeticaly() -> [WordCounted] {
        return self.wordsDict.sorted(by: { $0.0 < $1.0 }).map { WordCounted(word: $0.key, count: $0.value) }
    }

    private func sortByRepetitions() -> [WordCounted] {
        return self.wordsDict.sorted(by: { $0.1 < $1.1 }).map { WordCounted(word: $0.key, count: $0.value) }
    }

} // FileManager
