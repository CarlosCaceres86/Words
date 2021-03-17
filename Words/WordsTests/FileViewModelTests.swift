//
//  FileViewModelTests.swift
//  WordsTests
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import RxSwift
import XCTest
@testable import Words

class FileViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    let viewModel = FileViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadFileWithoutFileName() {
        let expectation = self.expectation(description: "FileLoading")
        var error = ""

        disposeBag.insert(
            viewModel.output.onLoadError.bind { errorMsg in
                expectation.fulfill()
                error = errorMsg
            }
        )

        viewModel.input.loadFile.onNext(nil)

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(error == "File name can not be empty")
    }

    func testLoadFileWithWrongFileName() {
        let expectation = self.expectation(description: "FileLoading")
        var error = ""

        disposeBag.insert(
            viewModel.output.onLoadError.bind { errorMsg in
                expectation.fulfill()
                error = errorMsg
            }
        )

        viewModel.input.loadFile.onNext("WrongFileName")

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(error == "Couldn't load file content. Please, check that the file name is correct")
    }

    func testLoadFileWithRightFileName() {
        let expectation = self.expectation(description: "FileLoading")
        var result: String?

        disposeBag.insert(
            viewModel.output.onLoadDone.bind { fileContent in
                expectation.fulfill()
                result = fileContent
            }
        )

        viewModel.input.loadFile.onNext("Nombres")

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(result != nil)
    }

}
