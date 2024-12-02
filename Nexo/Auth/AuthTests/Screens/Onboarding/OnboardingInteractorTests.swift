//
//  OnboardingInteractorTests.swift
//  AuthTests
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
//

import XCTest
@testable import Auth
@testable import Shared

final class OnboardingInteractorTests: XCTestCase {
    var loginInteractor: LoginInteractor!
    var mockLoginService: MockLoginService!
    var mockLoginPresenter: MockLoginPresenter!
    
    override func setUp() {
        super.setUp()
        mockLoginService = MockLoginService()
        mockLoginPresenter = MockLoginPresenter()
        loginInteractor = LoginInteractor(service: mockLoginService, presenter: mockLoginPresenter)
    }
    
    override func tearDown() {
        loginInteractor = nil
        mockLoginService = nil
        mockLoginPresenter = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let expectation = XCTestExpectation(description: "LoginInteractor calls presenter on success")
        let expectedResponse = AuthenticateResponse(token: "someToken")
        mockLoginService.mockLoginResponse = expectedResponse
        loginInteractor.login(username: "123456789", password: "password")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockLoginPresenter.didPresentSuccess)
            XCTAssertEqual(self.mockLoginPresenter.presentedToken?.token, expectedResponse.token)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoginFailure() {
        let expectation = XCTestExpectation(description: "LoginInteractor handles error correctly")
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])
        mockLoginService.mockLoginError = expectedError
        loginInteractor.login(username: "123456789", password: "wrongPassword")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockLoginPresenter.didPresentError)
            XCTAssertEqual((self.mockLoginPresenter.presentedError as NSError?)?.localizedDescription, expectedError.localizedDescription)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

