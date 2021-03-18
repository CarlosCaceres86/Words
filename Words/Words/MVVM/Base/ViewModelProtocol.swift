//
//  ViewModelProtocol.swift
//  Words
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import Foundation

/// Define that all View Model must have some inputs
/// and this inputs will produce some outputs
public protocol ViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
}
