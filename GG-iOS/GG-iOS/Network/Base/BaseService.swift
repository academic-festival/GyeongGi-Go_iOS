//
//  BaseService.swift
//  GG-iOS
//
//  Created by 김승원 on 11/12/25.
//

import Foundation

import Moya

class BaseService<Target: BaseTargetType> {
    
    // MARK: - Properties
    
    private let provider: MoyaProvider<Target>
    
    // MARK: - Initializer
    
    init(
        plugins: [PluginType] = [MoyaLoggingPlugin()]
    ) {
        self.provider = MoyaProvider<Target>(
            plugins: plugins
        )
    }
    
    // MARK: - Request
    
    func request<T: ResponseModelType>(
        with target: Target
    ) async throws -> BaseResponseBody<T> {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    switch response.statusCode {
                    case 200...299:
                        do {
                            let decoded = try JSONDecoder().decode(
                                BaseResponseBody<T>.self,
                                from: response.data
                            )
                            continuation.resume(returning: decoded)
                        } catch {
                            continuation.resume(throwing: NetworkError.responseDecodingError)
                        }
                        
                    case 400, 409:
                        if let errorResponse = try? JSONDecoder().decode(
                            BaseResponseBody<T>.self,
                            from: response.data
                        ) {
                            continuation.resume(throwing: NetworkError.apiError(message: errorResponse.message))
                        } else {
                            continuation.resume(throwing: NetworkError.responseError)
                        }
                        
                    case 401, 403:
                        continuation.resume(throwing: NetworkError.unauthorized)
                    case 404:
                        continuation.resume(throwing: NetworkError.notFound)
                    case 500...599:
                        continuation.resume(throwing: NetworkError.internalServerError)
                    default:
                        continuation.resume(throwing: NetworkError.responseError)
                    }
                    
                case .failure:
                    continuation.resume(throwing: NetworkError.networkFail)
                }
            }
        }
    }
}
