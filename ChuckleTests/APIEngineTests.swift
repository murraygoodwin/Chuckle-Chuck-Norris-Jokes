//
//  ChuckleTests.swift
//  ChuckleTests
//
//  Created by Murray Goodwin on 20/10/2020.
//

import XCTest
@testable import Chuckle

class APIEngineTests: XCTestCase {
  
  var sut: APIEngine!

  override func setUp() {
    super.setUp()
    sut = APIEngine()
  }
  
  func testSuccessfullyDownloadingDataFromAPI() {
    let expectation = self.expectation(description: "RetrievingData")
    var data: Data?

    sut.downloadJokesAsJSON(numberOfJokes: 5, excludeExplicitJokes: true) {
      data = $0
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(data)
  }
 }
