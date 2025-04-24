//
//  LoginPresenterTests.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import XCTest
@testable import Movies_Viper

class LoginPresenterTests: XCTestCase {

    var presenter: LoginPresenter!
    var mockView: LoginViewMock!
    var mockRouter: LoginRouterMock!
    var mockInteractor: LoginInteractorMock!

    override func setUp() {
        super.setUp()
        mockView = LoginViewMock()
        mockRouter = LoginRouterMock()
        mockInteractor = LoginInteractorMock()
        
        presenter = LoginPresenter()
        presenter.view = mockView
        presenter.router = mockRouter
        presenter.interactor = mockInteractor
        mockInteractor.output = presenter
    }

    func test_loginTapped_emptyFields_showsError() {
        presenter.loginTapped(username: "", password: "")

        XCTAssertTrue(mockView.didShowError)
        XCTAssertEqual(mockView.errorMessage, "Please enter username and password")
    }

    func test_loginTapped_emptyPassword_showsError() {
        presenter.loginTapped(username: "Admin", password: "")

        XCTAssertTrue(mockView.didShowError)
        XCTAssertEqual(mockView.errorMessage, "Please enter username and password")
    }

    func test_loginTapped_success_navigatesToMovies() {
        presenter.loginTapped(username: "Admin", password: "Password*123")

        XCTAssertTrue(mockRouter.didNavigateToMovieList)
        XCTAssertFalse(mockView.didShowError)
    }

    func test_loginTapped_invalidCredentials_showsError() {
        presenter.loginFailed(error: "Invalid credentials")

        XCTAssertTrue(mockView.didShowError)
        XCTAssertEqual(mockView.errorMessage, "Invalid credentials")
    }
    
    func test_loginTapped_success_navigatesToMovieList() {
        // Simula login exitoso
        presenter.loginSucceeded()

        // Verifica que se llamó a la navegación
        XCTAssertTrue(mockRouter.didNavigateToMovieList)
    }
    
    func test_loginTapped_validatesWhitespaceInputs() {
        presenter.loginTapped(username: "   ", password: "   ")
        
        XCTAssertTrue(mockView.didShowError)
        XCTAssertEqual(mockView.errorMessage, "Please enter username and password")
    }

    func test_loginTapped_partialWhitespace_fails() {
        presenter.loginTapped(username: "Admin", password: "  ")
        
        XCTAssertTrue(mockView.didShowError)
        XCTAssertEqual(mockView.errorMessage, "Please enter username and password")
    }

    func test_loginTapped_success_trimsInput() {
        presenter.loginTapped(username: "  Admin ", password: " Password*123 ")
        
        XCTAssertTrue(mockRouter.didNavigateToMovieList)
    }
    
    func test_loginFlow_validCredentials_triggersSuccess() {
        presenter.loginTapped(username: "Admin", password: "Password*123")

        XCTAssertTrue(mockInteractor.didValidateUser)
        XCTAssertEqual(mockInteractor.lastUsername, "Admin")
        XCTAssertEqual(mockInteractor.lastPassword, "Password*123")
        XCTAssertTrue(mockRouter.didNavigateToMovieList)
    }
    
    func test_loginFlow_invalidCredentials_showsError() {
        presenter.loginTapped(username: "wrong", password: "wrong123")

        XCTAssertTrue(mockInteractor.didValidateUser)
        XCTAssertEqual(mockInteractor.lastUsername, "wrong")
        XCTAssertEqual(mockInteractor.lastPassword, "wrong123")
        XCTAssertTrue(mockView.didShowError)
        XCTAssertEqual(mockView.errorMessage, "Invalid credentials")
    }

}

