//
//  LoginPresenterTests.swift
//  AuthTests
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import XCTest
@testable import Auth
@testable import Shared

final class LoginPresenterTests: XCTestCase {
    
    var loginPresenter: LoginPresenter!
    var mockLoginView: MockLoginView!
    
    override func setUp() {
        super.setUp()
        mockLoginView = MockLoginView()
        loginPresenter = LoginPresenter(view: mockLoginView)
    }
    
    override func tearDown() {
        loginPresenter = nil
        mockLoginView = nil
        super.tearDown()
    }
    
    func testPresentLoginSuccess() {
        let expectedResponse = AuthenticateResponse(token: "someToken", message: "someMessage")
        let expectation = expectation(description: "Wait for async displayLoginSuccess call")
        
        mockLoginView.onDisplaySuccess = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: expectedResponse, error: nil)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockLoginView.didDisplaySuccess, "Expected the view to display a success message.")
        XCTAssertEqual(mockLoginView.displayedToken?.token, expectedResponse.token, "Expected the token displayed to match the response.")
    }
    
    func testPresentLoginErrorWithAPIError() {
        let expectedError = NetworkError.apiError("Invalid credentials")
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockLoginView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, expectedError.description, "Expected the error message to match the API error description.")
    }
    
    func testPresentLoginErrorWithStatusCode() {
        let expectedError = NetworkError.statusCode(401, "Unauthorized")
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockLoginView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, expectedError.description, "Expected the error message to match the status code error description.")
    }
    
    func testPresentLoginErrorWithNoData() {
        let expectedError = NetworkError.noData
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockLoginView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, expectedError.description, "Expected the error message to match the no data error description.")
    }
    
    func testPresentLoginErrorWithDecodingError() {
        let decodingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock decoding error"])
        let expectedError = NetworkError.decodingError(decodingError)
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockLoginView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, expectedError.description, "Expected the error message to match the decoding error description.")
    }
    
    func testPresentLoginErrorWithoutSpecificError() {
        let expectation = expectation(description: "Wait for async displayLoginError call")
        
        mockLoginView.onDisplayError = { expectation.fulfill() }
        
        loginPresenter.presentLoginResult(token: nil, error: nil)
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, "Login failed.", "Expected the default error message to be displayed.")
    }
}

final class MockLoginView: LoginViewProtocol {
    var didDisplaySuccess = false
    var didDisplayError = false
    var displayedToken: AuthenticateResponse?
    var displayedError: String?
    
    var onDisplaySuccess: (() -> Void)?
    var onDisplayError: (() -> Void)?
    
    func displayLoginSuccess(with token: AuthenticateResponse) {
        didDisplaySuccess = true
        displayedToken = token
        onDisplaySuccess?()
    }
    
    func displayLoginError(_ message: String) {
        didDisplayError = true
        displayedError = message
        onDisplayError?()
    }
}
