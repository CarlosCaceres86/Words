//
//  BaseViewController.swift
//  Words
//
//  Created by Carlos Cáceres González on 19/03/2021.
//

import UIKit

/// Base ViewController. It contains some generic functions.
/// Every ViewController should inherit from it or from his children.
class BaseViewController: UIViewController {

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        initComponents()
    }

    // MARK: Functions
    func initComponents() {
        hideKeyBoardGesture()
    }

    /// Hides the keyboard on tap
    private func hideKeyBoardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

} // BaseViewController
