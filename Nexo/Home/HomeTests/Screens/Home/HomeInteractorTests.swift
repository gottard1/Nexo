//
//  HomeInteractorTests.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/02/25.
//


import XCTest
@testable import Home
@testable import Shared

final class HomeInteractorTests: XCTestCase {
    
    var homeInteractor: HomeInteractor!
    var mockHomeService: MockHomeService!
    var mockHomePresenter: MockHomePresenter!
    
    override func setUp() {
        super.setUp()
        mockHomeService = MockHomeService()
        mockHomePresenter = MockHomePresenter()
        homeInteractor = HomeInteractor(service: mockHomeService, presenter: mockHomePresenter)
    }
    
    override func tearDown() {
        homeInteractor = nil
        mockHomeService = nil
        mockHomePresenter = nil
        super.tearDown()
    }
    
    func testHomeSuccess() {
        let expectation = XCTestExpectation(description: "LoginInteractor calls presenter on success")
        let expectedResponse = MockSDUIBuilder.make()
        mockHomeService.mockHomeResponse = expectedResponse
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.mockLoginPresenter.didPresentSuccess)
            XCTAssertEqual(self.mockLoginPresenter.presentedToken?.token, expectedResponse.token)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testHomeFailure() {
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

class MockHomeService: HomeServiceProtocol {
    var mockHomeResponse: SDUIBuilder?
    var mockHomeError: Error?
    
    func login(cpfCnpj: String, password: String) async throws -> AuthenticateResponse {
        if let error = mockHomeError {
            throw error
        }
        guard let response = mockHomeResponse else {
            fatalError("Mock response not set")
        }
        return response
    }
}

class MockHomePresenter: HomePresenterProtocol {
    var didPresentSuccess = false
    var didPresentError = false
    var presentedBuilder: SDUIBuilder?
    
    func presentHomeResult(_ components: [SDUIComponentData]?, error: NetworkError?) {
        if let components = components {
            didPresentSuccess = true
            presentedBuilder = SDUIBuilder(components: components)
        } else {
            didPresentError = true
        }
    }
}
