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
        let expectation = XCTestExpectation(description: "Presenter updates view on success")
        let expectedResponse = AuthenticateResponse(token: "someToken")
        
        loginPresenter.presentLoginResult(token: expectedResponse, error: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockLoginView.didDisplaySuccess)
            XCTAssertEqual(self.mockLoginView.displayedToken?.token, expectedResponse.token)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testPresentLoginError() {
        let expectation = XCTestExpectation(description: "Presenter updates view on error")
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockLoginView.didDisplayError)
            XCTAssertEqual(self.mockLoginView.displayedError?.localizedDescription, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

final class MockLoginView: LoginViewProtocol {
    var didDisplaySuccess = false
    var didDisplayError = false
    var displayedToken: AuthenticateResponse?
    var displayedError: Error?
    
    func displayLoginSuccess(with token: AuthenticateResponse) {
        didDisplaySuccess = true
        displayedToken = token
    }
    
    func displayLoginError(_ message: String) {
        didDisplayError = true
        displayedError = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
