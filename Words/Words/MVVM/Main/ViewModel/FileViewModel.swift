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
    private var disposeBag: DisposeBag
    private let fileLoader: FileLoader


    // MARK: Constructors
    init() {
        input  = Input(loadFile: loadFile.asObserver())
        output = Output(onLoadError: onLoadError.asObserver(),
                        onLoadDone: onLoadDone.asObserver())

        disposeBag = DisposeBag()
        fileLoader = FileLoader()

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
                guard nil != fileName && !fileName!.isEmpty else {
                    self!.onLoadError.onNext("File name can not be empty")
                    NSLog("File name can not be empty")
                    return
                }
                guard let fileContent = self!.fileLoader.load(fileName: fileName!) else {
                    self!.onLoadError.onNext("Couldn't load file content. Please, check that the file name is correct")
                    NSLog("Couldn't load file content. Please, check that the file name is correct")
                    return
                }

                NSLog(fileContent)
                self!.onLoadDone.onNext(fileContent)
            }
        )
    }

    private func configureOutputs() {

    }
    
} // FileViewModel
