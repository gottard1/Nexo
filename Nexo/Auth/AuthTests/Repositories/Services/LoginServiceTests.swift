//
//  LoginServiceTests.swift
//  AuthTests
//
//  Created by Marcel Felipe Gottardi Anesi on 29/11/24.
//

import XCTest
@testable import Auth
@testable import Shared

final class LoginServiceTests: XCTestCase {
    
    var loginService: LoginService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        loginService = LoginService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        loginService = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testLoginSuccess() async throws {
        let expectedResponse = AuthenticateResponse(token: "someToken", message: "someMessage")
        mockNetworkManager.mockResponse = expectedResponse
        
        let result = try await loginService.login(cpfCnpj: "12345678910", password: "password")
        
        XCTAssertEqual(result.token, expectedResponse.token)
    }
    
    func testLoginFailure() async throws {
        mockNetworkManager.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        do {
            _ = try await loginService.login(cpfCnpj: "12345678910", password: "password")
            XCTFail("Expected error but got a successful response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

// Mock NetworkManager to simulate network calls
class MockNetworkManager: Networking {
    var mockResponse: AuthenticateResponse?
    var mockError: Error?
    
    func request<T>(target: BaseTarget, responseType: T.Type) async throws -> T where T : Decodable {
        if let error = mockError {
            throw error
        }
        guard let response = mockResponse as? T else {
            fatalError("Response type mismatch")
        }
        return response
    }
}
