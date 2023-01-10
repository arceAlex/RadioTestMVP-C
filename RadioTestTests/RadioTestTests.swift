//
//  RadioTestTests.swift
//  RadioTestTests
//
//  Created by Alejandro Arce on 3/1/23.
//

import XCTest
import AVFoundation
import OHHTTPStubs
@testable import RadioTest

class RadioTestTests: XCTestCase {
    // sut -> System Under Test
    var sutRadioPresenter : RadioPresenter = RadioPresenter()
    var sutDelegate : RadioVCMock = RadioVCMock()
    
    
    func test_GetStations() {
        sutRadioPresenter.delegate = sutDelegate
        sutDelegate.expGetSendStations = expectation(description: "get stations")
        sutRadioPresenter.getStations()
        waitForExpectations(timeout: 10.0)
        XCTAssertTrue(sutRadioPresenter.radioJson!.count > 10)
    }
    
    func testGetData() {
        stub(condition: isHost("mywebservice.com")) { _ in
          let obj = ["key1":"value1", "key2":["value2A","value2B"]]
           return  HTTPStubsResponse(jsonObject: obj, statusCode: 100, headers: nil)
         // return OHHTTPStubsResponse(JSONObject: obj, statusCode: 200, headers: nil)
        }

    }
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

class RadioVCMock : RadioPresenterDelegate {
    var sendStationsWasCalled : Bool = false
    var expGetSendStations : XCTestExpectation?
    
    func sendStations(stations: [RadioModel]) {
        sendStationsWasCalled = true
        expGetSendStations?.fulfill()
        
    }
    
    func reproductorLoading() {
        print("Hola")
    }
    
    func setPause() {
        print("Hola")
    }
    
    func setPlay() {
        print("Hola")
    }
    
    func createObserver() {
        print("Hola")
    }
    
    func restartPlayer() {
        print("Hola")
    }
    
    func showStatusValuesInScreen(playerItem: AVPlayerItem, player: AVPlayer) {
        print("Hola")
    }
    
    func setReproductionFailed() {
        print("Hola")
    }
    
    
}
