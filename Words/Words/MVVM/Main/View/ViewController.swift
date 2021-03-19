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
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setErrorTo(visible: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureObservers()
    }

    // MARK: Functions
    // MARK: Observers
    private func configureObservers() {
        self.configureInputs()
        self.configureOutputs()
    }

    private func configureInputs() {
        self.disposeBag.insert(
            self.loadBtn.rx.tap.bind { [weak self] in
                guard nil != self else { return }

                self!.setErrorTo(visible: false)
                self!.viewModel.input.loadFile.onNext(self!.fileNameTextfield.text)
            }
        )
    }

    private func configureOutputs() {
        self.disposeBag.insert(
            self.viewModel.output.onLoadError.bind { [weak self] errorMsg in
                guard nil != self else { return }
                self!.setErrorMsg(text: errorMsg)
            },

            self.viewModel.output.onLoadDone.bind { [weak self] totalWords in
                guard nil != self else { return }
                DispatchQueue.main.async {
                    self!.totalWordsLabel.text = String(format: "totalWordsLabel".localized, totalWords)
                }
            },

            self.viewModel.output.words.bind(to: tableView.rx.items(cellIdentifier: "wordCell")) { row, model, cell in
                guard let wordCell = cell as? WordTableViewCell else { return }
                wordCell.setCell(word: model)
            }
        )
    }

    // MARK: Private
    private func setErrorTo(visible: Bool) {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = !visible
        }
    }

    private func setErrorMsg(text: String) {
        setErrorTo(visible: true)
        DispatchQueue.main.async {
            self.errorLabel.text = text
        }
    }

} // ViewController

