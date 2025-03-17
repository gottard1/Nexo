//
//  HomeServiceTests.swift
//  Home
//
//  Created by Marcel Felipe Gottardi Anesi on 10/02/25.
//

import XCTest
@testable import Home
@testable import Shared

final class HomeServiceTests: XCTestCase {
    
    var homeService: HomeService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        homeService = HomeService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        homeService = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testLoginSuccess() async throws {
        let expectedResponse = MockSDUIBuilder.make()
        mockNetworkManager.mockResponse = expectedResponse
        
        let result = try await homeService.fetchHome()
        
        XCTAssertEqual(result.components.count, expectedResponse.components.count)
        
        for (index, component) in result.components.enumerated() {
            let expectedComponent = expectedResponse.components[index]
            XCTAssertEqual(component.componentType, expectedComponent.componentType)
            XCTAssertEqual(component.config?.colors?.background, expectedComponent.config?.colors?.background)
        }
    }
    
    func testLoginFailure() async throws {
        mockNetworkManager.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        do {
            _ = try await homeService.fetchHome()
            XCTFail("Expected error but got a successful response")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

class MockNetworkManager: Networking {
    var mockResponse: SDUIBuilder?
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
