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
        
        loginPresenter.presentLoginResult(token: expectedResponse, error: nil)
        
        XCTAssertTrue(mockLoginView.didDisplaySuccess, "Expected the view to display a success message.")
        XCTAssertEqual(mockLoginView.displayedToken?.token, expectedResponse.token, "Expected the token displayed to match the response.")
    }
    
    func testPresentLoginErrorWithAPIError() {
        let expectedError = NetworkError.apiError("Invalid credentials")
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, "Erro na API: Invalid credentials", "Expected the error message to match the API error description.")
    }
    
    func testPresentLoginErrorWithStatusCode() {
        let expectedError = NetworkError.statusCode(401, "Unauthorized")
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, "Erro de status 401: Unauthorized", "Expected the error message to match the status code error description.")
    }
    
    func testPresentLoginErrorWithNoData() {
        let expectedError = NetworkError.noData
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, "Nenhum dado foi retornado da API.", "Expected the error message to match the no data error description.")
    }
    
    func testPresentLoginErrorWithDecodingError() {
        let decodingError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock decoding error"])
        let expectedError = NetworkError.decodingError(decodingError)
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, "Erro ao decodificar a resposta: Mock decoding error", "Expected the error message to match the decoding error description.")
    }
    
    func testPresentLoginErrorWithoutSpecificError() {
        let expectedError: NetworkError? = nil
        
        loginPresenter.presentLoginResult(token: nil, error: expectedError)
        
        XCTAssertTrue(mockLoginView.didDisplayError, "Expected the view to display an error message.")
        XCTAssertEqual(mockLoginView.displayedError, "Login failed.", "Expected the default error message to be displayed.")
    }
}

final class MockLoginView: LoginViewProtocol {
    var didDisplaySuccess = false
    var didDisplayError = false
    var displayedToken: AuthenticateResponse?
    var displayedError: String?
    
    func displayLoginSuccess(with token: AuthenticateResponse) {
        didDisplaySuccess = true
        displayedToken = token
    }
    
    func displayLoginError(_ message: String) {
        didDisplayError = true
        displayedError = message
    }
}
