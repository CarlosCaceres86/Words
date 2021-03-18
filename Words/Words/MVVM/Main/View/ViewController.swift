//
//  ViewController.swift
//  Words
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import UIKit

import RxSwift

class ViewController: UIViewController {

    // MARK: Properties
    // MARK: Private
    private let disposeBag = DisposeBag()
    private let viewModel: FileViewModel = FileViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var fileNameTextfield: UITextField!
    @IBOutlet weak var loadBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureObservers()
    }

    // MARK: Functions
    // MARK: Observers
    private func configureObservers() {
        configureInputs()
        configureOutputs()
    }

    private func configureInputs() {
        disposeBag.insert(
            loadBtn.rx.tap.bind { [weak self] in
                guard nil != self else { return }
                self!.viewModel.input.loadFile.onNext(self!.fileNameTextfield.text)
            }
        )
    }

    private func configureOutputs() { }

} // ViewController

