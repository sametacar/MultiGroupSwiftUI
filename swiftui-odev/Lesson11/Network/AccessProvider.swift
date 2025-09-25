//
//  AccessProvider.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//

import Foundation

protocol AccessProviderProtocol {
    func apiKey() -> String?
}

final class AccessProvider: AccessProviderProtocol {
    func apiKey() -> String? {
        //ProcessInfo.processInfo.environment[""]
        return nil
    }
}
