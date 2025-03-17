//
//  HomePresenterTests.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/02/25.
//

import XCTest
@testable import Home
@testable import Shared

final class HomePresenterTests: XCTestCase {
    
    var homePresenter: HomePresenter!
    var mockHomeView: MockHomeView!
    
    override func setUp() {
        super.setUp()
        mockHomeView = MockHomeView()
        homePresenter = HomePresenter(view: mockHomeView)
    }
    
    override func tearDown() {
        homePresenter = nil
        mockHomeView = nil
        super.tearDown()
    }
    
    func testPresentHomeSuccess() {
        let expectedResponse = AuthenticateResponse(token: "someToken", message: "someMessage")
        let expectation = expectation(description: "Wait for async displayLoginSuccess call")
        
        mockHomeView.onDisplaySuccess = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: expectedResponse, error: nil)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockHomeView.didDisplaySuccess, "Expected the view to display a success message.")
        XCTAssertEqual(mockHomeView.displayedToken?.token, expectedResponse.token, "Expected the token displayed to match the response.")
    }
    
    func testPresentHomeErrorWithAPIError() {
        let expectedError = NetworkError.apiError("Invalid credentials")
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockHomeView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockHomeView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockHomeView.displayedError, expectedError.description, "Expected the error message to match the API error description.")
    }
    
    func testPresentHomeErrorWithStatusCode() {
        let expectedError = NetworkError.statusCode(401, "Unauthorized")
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockHomeView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockHomeView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockHomeView.displayedError, expectedError.description, "Expected the error message to match the status code error description.")
    }
    
    func testPresentHomeErrorWithNoData() {
        let expectedError = NetworkError.noData
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockHomeView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockHomeView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockHomeView.displayedError, expectedError.description, "Expected the error message to match the no data error description.")
    }
    
    func testPresentHomeErrorWithDecodingError() {
        let decodingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock decoding error"])
        let expectedError = NetworkError.decodingError(decodingError)
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockHomeView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockHomeView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockHomeView.displayedError, expectedError.description, "Expected the error message to match the decoding error description.")
    }
    
    func testPresentHomeErrorWithoutSpecificError() {
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockHomeView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: nil)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockHomeView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockHomeView.displayedError, "Login failed.", "Expected the default error message to be displayed.")
    }
}

final class MockHomeView: HomeViewProtocol {
    var didDisplaySuccess = false
    var didDisplayError = false
    var displayedBuilder: SDUIBuilder?
    var displayedError: String?
    
    var onDisplaySuccess: (() -> Void)?
    var onDisplayError: (() -> Void)?
    
    func displayHomeSuccess(with components: [SDUIComponentData]) {
        didDisplaySuccess = true
        displayedBuilder = SDUIBuilder(components: components)
        onDisplaySuccess?()
    }
    
    func displayHomeError(_ message: String) {
        didDisplayError = true
        displayedError = message
        onDisplayError?()
    }
}
