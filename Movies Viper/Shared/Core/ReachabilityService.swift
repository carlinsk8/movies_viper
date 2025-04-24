//
//  ReachabilityService.swift
//  Movies Viper
//
//  Created by Carlos on 24/04/25.
//

import SystemConfiguration

protocol ReachabilityChecking {
    func isConnectedToNetwork() -> Bool
}

class ReachabilityService: ReachabilityChecking {
    static let shared = ReachabilityService() // Singleton real
    private init() {}

    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else { return false }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) { return false }

        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }
}
