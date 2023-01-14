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
    var jsonStub: HTTPStubsDescriptor?

    func test_GetStationsAllOk() {
        let stubPath = OHPathForFile("stubJson.json", type(of: self))!
        jsonStub = stub(condition: isHost("api.jsonbin.io")) { _ in
            return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 200, headers: nil)
        }
        sutRadioPresenter.delegate = sutDelegate
        sutDelegate.expGetSendStations = expectation(description: "get stations")
        sutRadioPresenter.getStations()
        waitForExpectations(timeout: 10.0)
        XCTAssertTrue(sutRadioPresenter.radioJson!.count == 7)
    }
    func test_GetStationsCodeError() {
        let stubPath = OHPathForFile("stubJson.json", type(of: self))!
        jsonStub = stub(condition: isHost("api.jsonbin.io")) { _ in
            return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 1000, headers: nil)
        }
        sutRadioPresenter.delegate = sutDelegate
        sutDelegate.expGetSendAlerts = expectation(description: "Code Error")
        sutRadioPresenter.getStations()
        waitForExpectations(timeout: 10.0)
        XCTAssertTrue(sutRadioPresenter.jsonError == .codeError)
    }
    func test_GetStationsTimeout() {
        let stubPath = OHPathForFile("stubJson.json", type(of: self))!
        jsonStub = stub(condition: isHost("api.jsonbin.io")) { _ in
            return HTTPStubsResponse(fileAtPath: stubPath, statusCode: 200, headers: nil)
                .requestTime(0, responseTime: 25)
        }
        sutRadioPresenter.delegate = sutDelegate
        sutDelegate.expGetSendAlerts = expectation(description: "Timeout")
        sutRadioPresenter.getStations()
        waitForExpectations(timeout: 30.0)
        XCTAssertTrue(sutRadioPresenter.jsonError == .timeOut)
    }
    func removeStub() {
        if let jsonStub = jsonStub {
            HTTPStubs.removeStub(jsonStub)
        }
    }
    

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        removeStub()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sutDelegate.expGetSendAlerts = nil
    }
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
    var expGetSendStations : XCTestExpectation?
    var expGetSendAlerts : XCTestExpectation?
    
    func sendAlerts(message: String, buttonTitle: String) {
        expGetSendAlerts?.fulfill()
    }
    
    func sendStations(stations: [RadioModel]) {
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
