//
//  RickApiClient.swift
//  odev_ApiVeriList
//
//  Created by vili on 24.09.2025.
//


import Foundation
import BuddiesNetwork

final class RickApiClient {
    let apiClient: APIClient
    public static var shared: RickApiClient!
    
    init(networkTransporter: NetworkTransportProtocol) {
        apiClient = .init(networkTransporter: networkTransporter)
    }
    
    /// Reaches into Network Library
   @discardableResult
   public func perform<Request: Requestable>(
       _ request: Request,
       dispatchQueue: DispatchQueue = .main,
       cachePolicy: CachePolicy = .fetchIgnoringCacheCompletely,
       completion: @escaping HTTPResultHandler<Request>
   ) -> (any Cancellable)? {
       return apiClient.perform(
           request,
           dispatchQueue: dispatchQueue,
           cachePolicy: cachePolicy,
           completion: completion
       )
   }
    
    /// Conveniently lets us create network requests in the project
    public func perform<Request: Requestable>(
        _ request: Request,
        cachePolicy: CachePolicy = .fetchIgnoringCacheCompletely,
        dispatchQueue: DispatchQueue = .main
    ) async throws -> Request.Data {
        try await withCheckedThrowingContinuation { continuation in
            let _ = self.apiClient.perform(
                request,
                dispatchQueue: dispatchQueue,
                cachePolicy: cachePolicy
            ) { result in
                switch result {
                case let .success(success):
                    continuation.resume(returning: success.data)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


extension HTTPResult {
    func isFinalForCachePolicy(policy: CachePolicy) -> Bool {
        switch policy {
        case .returnCacheDataElseFetch:
            return true
        case .fetchIgnoringCacheData:
            return source == .server
        case .fetchIgnoringCacheCompletely:
            return source == .server
        case .returnCacheDataDontFetch:
            return source == .cache
        case .returnCacheDataAndFetch:
            return source == .server
        }
    }
}
