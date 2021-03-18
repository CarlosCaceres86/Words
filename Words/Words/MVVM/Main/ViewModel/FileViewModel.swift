//
//  FileViewModel.swift
//  Words
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import Foundation

import RxSwift
import RxCocoa

class FileViewModel: ViewModelProtocol {

    struct Input {
        let loadFile: AnyObserver<String?>
    }

    struct Output {
        let onLoadError: Observable<String>
        let onLoadDone: Observable<String>
    }

    // MARK: Subjects
    // MARK: Input
    private let loadFile = PublishSubject<String?>()
    // MARK: Output
    private let onLoadError = PublishSubject<String>()
    private let onLoadDone = PublishSubject<String>()

    // MARK: Properties
    // MARK: Internal
    var input: Input
    var output: Output
    // MARK: Private
    private let disposeBag: DisposeBag = DisposeBag()
    private let fileLoader: FileLoader = FileLoader()


    // MARK: Constructors
    init() {
        input  = Input(loadFile: loadFile.asObserver())
        output = Output(onLoadError: onLoadError.asObserver(),
                        onLoadDone: onLoadDone.asObserver())

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
            loadFile.bind { [weak self] fileName in
                guard nil != self else { return }
                self!.performLoadFile(fileName: fileName)
            }
        )
    }

    private func configureOutputs() {

    }

    // MARK: Private
    private func performLoadFile(fileName: String?) {
        guard nil != fileName && !fileName!.isEmpty else {
            onLoadError.onNext("fileNameEmptyMsg".localized)
            NSLog("fileNameEmptyMsg".localized)
            return
        }
        guard let fileContent = fileLoader.load(fileName: fileName!) else {
            onLoadError.onNext("fileNotLoadedMsg".localized)
            NSLog("fileNotLoadedMsg".localized)
            return
        }

        NSLog(fileContent)
        onLoadDone.onNext(fileContent)
    }
    
} // FileViewModel
