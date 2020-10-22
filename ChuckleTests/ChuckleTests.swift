//
//  ChuckleTests.swift
//  ChuckleTests
//
//  Created by Murray Goodwin on 20/10/2020.
//

import XCTest
@testable import Chuckle

class ChuckleTests: XCTestCase {
  
  var sut: APIEngine!

  override func setUp() {
    super.setUp()
    sut = APIEngine()
  }
  
  func testSuccessfullyDownloadingDataFromAPI() {
    sut.downloadJokesAsJSON(numberOfJokes: 5, excludeExplicitJokes: true) { (data) in
      XCTAssertNotNil(data)
    }
  }
  
  func testRequesting0JokesFromAPI() {
    sut.downloadJokesAsJSON(numberOfJokes: 0, excludeExplicitJokes: true) { (data) in
      
      // NEEDS BETTER HANDLING OF THIS
      
    }
  }
  
  func testParsingJSON() {
    
  }
  
  func testUpdatingViewModel() {
    
  }
  
  

}
