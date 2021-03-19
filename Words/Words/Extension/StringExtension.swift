//
//  StringExtension.swift
//  Words
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import Foundation

extension String {

    /// Allows the string localization code to be much more clean
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    /// Array of substrings inside a string
    var words: [String] {
        var words: [String] = []

        self.enumerateSubstrings(in: self.startIndex..., options: [.byWords]) { _, range, _, _ in
            words.append(String(self[range]))
        }

        return words
    }

    /// Delete all non-supported symbols and lowercase the string
    var sanitized: String {
        let nonSupportedSymbols = CharacterSet(arrayLiteral: ".", ",", "'", ";", "\"", ":", "`", "´", "(", ")", "-", "_", ":", "?", "!")

        return self.components(separatedBy: nonSupportedSymbols).joined(separator: "").lowercased()
    }


} // String
