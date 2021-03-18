//
//  StringExtension.swift
//  Words
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import Foundation

extension String {

    /// Allows the string localization code to be much more clear
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

} // String
