//
//  QuickstartAppTests.swift
//  QuickstartAppTests
//
//  Created by grkim on 2022/05/13.
//

import XCTest

class QuickstartAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAPIKey() {
        let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
        XCTAssertNotEqual(apiKey, "", "Empty API_Key")
    }
}
