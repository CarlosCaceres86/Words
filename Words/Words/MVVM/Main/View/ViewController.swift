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
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

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
                DispatchQueue.main.async { self!.errorLabel.isHidden = true }
                self!.viewModel.input.loadFile.onNext(self!.fileNameTextfield.text)
            }
        )
    }

    private func configureOutputs() {
        disposeBag.insert(
            viewModel.output.onLoadError.bind { [weak self] errorMsg in
                DispatchQueue.main.async {
                    self!.errorLabel.isHidden = false
                    self!.errorLabel.text = errorMsg
                }
            }
        )
    }

} // ViewController

