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
    
    func testHandleButtonTap_navigateToRegisterDocument() {
        let expectedAction: AuthActions = .registerDocument
        
        interactor.handleButtonTap(action: expectedAction)
        
        switch mockView.didNavigateToAction {
            case .registerDocument:
                XCTAssertTrue(true, "navigateTo(action:) called with correct action.")
            default:
                XCTFail("navigateTo(action:) was not called with .registerDocument as expected.")
        }
    }
    
    func testHandleButtonTap_doesNotNavigateToOtherActions() {
        let unexpectedAction: AuthActions = .login
        
        interactor.handleButtonTap(action: .registerDocument)
        
        switch mockView.didNavigateToAction {
            case .login:
                XCTFail("navigateTo(action:) should not have been called with .login.")
            default:
                XCTAssertTrue(true, "navigateTo(action:) was not called with an incorrect action.")
        }
    }
}

final class MockOnboardingView: OnboardingViewProtocol {
    var didNavigateToAction: AuthActions?
    
    func navigateTo(action: AuthActions) {
        didNavigateToAction = action
    }
}
