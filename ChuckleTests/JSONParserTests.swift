//
//  JSONParserTests.swift
//  ChuckleTests
//
//  Created by Murray Goodwin on 22/10/2020.
//

import XCTest
@testable import Chuckle

class JSONParserTests: XCTestCase {

  var sut: JSONParser!
  var apiEngine: APIEngine!

  override func setUp() {
    super.setUp()
    sut = JSONParser()
    apiEngine = APIEngine()
  }
  
  func testParsingJSON() {
    let expectation = self.expectation(description: "RetrievingData")
    var data: Data?

    apiEngine.downloadJokesAsJSON(numberOfJokes: 5, excludeExplicitJokes: true) {
      data = $0
      expectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(data)

    XCTAssertTrue(sut.parseJSON(data: data!).count == 5)
  }
}
