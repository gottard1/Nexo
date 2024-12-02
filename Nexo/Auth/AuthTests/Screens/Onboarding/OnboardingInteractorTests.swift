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
    var interactor: OnboardingInteractor!
    var mockView: MockOnboardingView!
    var presenter: OnboardingPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockOnboardingView()
        presenter = OnboardingPresenter()
        interactor = OnboardingInteractor(presenter: presenter, view: mockView)
    }
    
    override func tearDown() {
        interactor = nil
        mockView = nil
        presenter = nil
        super.tearDown()
    }
    
    func testHandleButtonTap_callsNavigateToWithCorrectAction() {
        let expectedAction: AuthActions = .login
        interactor.handleButtonTap(action: expectedAction)
        
        XCTAssertEqual(mockView.didNavigateToAction, expectedAction, "Expected navigateTo(action:) to be called with \(expectedAction), but it wasn't.")
    }
    
    func testHandleButtonTap_callsNavigateToWithSignupAction() {
        let expectedAction: AuthActions = .register
        interactor.handleButtonTap(action: expectedAction)
        XCTAssertEqual(mockView.didNavigateToAction, expectedAction, "Expected navigateTo(action:) to be called with \(expectedAction), but it wasn't.")
    }
    
    func testHandleButtonTap_callsNavigateToWithStatusAction() {
        let expectedAction: AuthActions = .status
        interactor.handleButtonTap(action: expectedAction)
        XCTAssertEqual(mockView.didNavigateToAction, expectedAction, "Expected navigateTo(action:) to be called with \(expectedAction), but it wasn't.")
    }
    
    func testHandleButtonTap_shouldFailWithIncorrectAction() {
        let unexpectedAction: AuthActions = .register
        interactor.handleButtonTap(action: .login)
        XCTAssertNotEqual(mockView.didNavigateToAction, unexpectedAction, "navigateTo(action:) should not be called with \(unexpectedAction).")
    }
}

final class MockOnboardingView: OnboardingViewProtocol {
    var didNavigateToAction: AuthActions?
    
    func navigateTo(action: AuthActions) {
        didNavigateToAction = action
    }
}
