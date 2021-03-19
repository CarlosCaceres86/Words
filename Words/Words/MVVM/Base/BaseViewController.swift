//
//  BaseViewController.swift
//  Words
//
//  Created by Carlos Cáceres González on 19/03/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initComponents()
    }

    func initComponents() {
        hideKeyBoardGesture()
    }

    private func hideKeyBoardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

} // BaseViewController
