//
//  LoginInteractorTests.swift
//  AuthTests
//
//  Created by Marcel Felipe Gottardi Anesi on 02/12/24.
// 

import XCTest
@testable import Auth
@testable import Shared

final class LoginInteractorTests: XCTestCase {
    
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
        let expectedResponse = AuthenticateResponse(token: "someToken", message: "someMessage")
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
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockLoginService: LoginServiceProtocol {
    var mockLoginResponse: AuthenticateResponse?
    var mockLoginError: Error?
    
    func login(cpfCnpj: String, password: String) async throws -> AuthenticateResponse {
        if let error = mockLoginError {
            throw error
        }
        guard let response = mockLoginResponse else {
            fatalError("Mock response not set")
        }
        return response
    }
}

class MockLoginPresenter: LoginPresenterProtocol {
    var didPresentSuccess = false
    var didPresentError = false
    var presentedToken: AuthenticateResponse?
    
    func presentLoginResult(token: AuthenticateResponse?, error: NetworkError?) {
        if let token = token {
            didPresentSuccess = true
            presentedToken = token
        } else {
            didPresentError = true
        }
    }
}
