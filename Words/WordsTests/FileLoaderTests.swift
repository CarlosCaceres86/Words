//
//  FileLoaderTests.swift
//  WordsTests
//
//  Created by Carlos Cáceres González on 17/03/2021.
//

import XCTest
@testable import Words

class FileLoaderTests: XCTestCase {

    let fileLoader = FileLoader()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWrongFileName() {
        let result = fileLoader.load(fileName: "wrongFileName")
        XCTAssertEqual(result, nil)
    }

    func testRightFileName() {
        let result = fileLoader.load(fileName: "Nombres")
        XCTAssertTrue(result != nil)
    }

}
