//
//  ReachabilityMock.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

@testable import Movies_Viper

class ReachabilityMock: ReachabilityChecking {
    var isConnected = true

    func isConnectedToNetwork() -> Bool {
        return isConnected
    }
}
