import Foundation

protocol NetworkUseCaseRequest {
    func callAsFunction(_ request: URLRequest) async throws -> Data
}

enum NetworkUseCase {

    class Request: NetworkUseCaseRequest {

        func callAsFunction(_ request: URLRequest) async throws -> Data {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }
    }
}
