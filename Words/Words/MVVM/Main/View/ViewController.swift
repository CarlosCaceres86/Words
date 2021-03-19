//
//  ViewController.swift
//  Words
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import UIKit

import RxSwift

class ViewController: BaseViewController {

    // MARK: Properties
    // MARK: Private
    private let disposeBag = DisposeBag()
    private let viewModel: FileViewModel = FileViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var fileNameTextfield: UITextField!
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortAlphabeticalyBtn: UIButton!
    @IBOutlet weak var sortByRepetitionsBtn: UIButton!
    @IBOutlet weak var filterStackView: UIStackView!

    // MARK: Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setErrorTo(visible: false)
        self.setFilterView(visible: false)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initComponents()
        self.configureObservers()
    }

    override func initComponents() {
        super.initComponents()

        self.searchBar.delegate = self
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
                self!.viewModel.input.loadFile.onNext(self!.fileNameTextfield.text)
            },

            self.sortAlphabeticalyBtn.rx.tap.bind { [weak self] in
                guard nil != self else { return }
                self!.clearSearchBar()
                self!.viewModel.input.sort.onNext(.alphabetical)
            },

            self.sortByRepetitionsBtn.rx.tap.bind { [weak self] in
                guard nil != self else { return }
                self!.clearSearchBar()
                self!.viewModel.input.sort.onNext(.repetitions)
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
                self!.setErrorTo(visible: false)
                self!.setFilterView(visible: true)
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

    private func setFilterView(visible: Bool) {
        DispatchQueue.main.async {
            self.filterStackView.isHidden = !visible
        }
    }

    private func clearSearchBar() {
        DispatchQueue.main.async {
            self.searchBar.text = ""
        }
    }

} // ViewController

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.input.filter.onNext(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }

} // UISearchBarDelegate
