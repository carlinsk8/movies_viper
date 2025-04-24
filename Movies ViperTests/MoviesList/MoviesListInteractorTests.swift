//
//  MoviesListInteractorTests.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import XCTest
@testable import Movies_Viper

final class MoviesListInteractorTests: XCTestCase {
    var interactor: MoviesListInteractor!
    var outputMock: MoviesListInteractorOutputMock!
    var apiServiceMock: MoviesAPIServiceMock!
    var persistenceServiceMock: MoviePersistenceServiceMock!
    var reachabilityMock: ReachabilityMock!
    

    override func setUp() {
        super.setUp()
        outputMock = MoviesListInteractorOutputMock()
        apiServiceMock = MoviesAPIServiceMock()
        persistenceServiceMock = MoviePersistenceServiceMock()
        reachabilityMock = ReachabilityMock()
        reachabilityMock.isConnected = false

        interactor = MoviesListInteractor(
            apiService: apiServiceMock,
            persistenceService: persistenceServiceMock,
            reachability: reachabilityMock
        )
        interactor.output = outputMock
    }

    func test_fetchMovies_whenOffline_shouldLoadFromCache() {
        apiServiceMock.shouldSimulateNetworkError = true
        persistenceServiceMock.cachedMovies = [Movie(id: 1, title: "Offline Movie", overview: "...", posterPath: nil, voteAverage: 8.0, releaseDate: "2025-01-01")]

        interactor.fetchUpcomingMovies(page: 1)

        XCTAssertTrue(outputMock.didLoadFromCache)
    }
    
    func test_fetchMovies_whenOnline_shouldCallAPI() {
        apiServiceMock.shouldSimulateNetworkError = false
        let expectedMovie = Movie(id: 1, title: "Online Movie", overview: "...", posterPath: nil, voteAverage: 8.0, releaseDate: "2025-01-01")
        apiServiceMock.mockedMovies = [expectedMovie]

        let expectation = XCTestExpectation(description: "Wait for fetch to complete")

        interactor.fetchUpcomingMovies(page: 1)

        // Esperar un pequeño delay para que el completion se ejecute
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.outputMock.didFetchMovies)
            XCTAssertEqual(self.outputMock.fetchedMovies.first?.title, "Online Movie")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchMovies_whenOfflineAndNoCache_shouldShowError() {
        reachabilityMock.isConnected = false
        apiServiceMock.shouldSimulateNetworkError = true
        persistenceServiceMock.cachedMovies = []

        interactor.fetchUpcomingMovies(page: 1)

        XCTAssertTrue(outputMock.didShowError)
        XCTAssertEqual(outputMock.errorMessage, "Sin conexión y sin datos guardados.")
    }



}
