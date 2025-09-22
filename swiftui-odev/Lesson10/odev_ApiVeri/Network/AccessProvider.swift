//
//  AccessProvider.swift
//  odev_ApiVeri
//
//  Created by vili on 21.09.2025.
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
