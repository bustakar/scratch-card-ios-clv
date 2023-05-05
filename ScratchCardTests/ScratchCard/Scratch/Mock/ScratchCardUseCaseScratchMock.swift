import Foundation

@testable import ScratchCard

final class ScratchCardUseCaseScratchMock: ObservableObject, ScratchCardUseCaseScratch {

    @Published var called = 0
    @Published var finished = 0

    func callAsFunction() async throws {
        called += 1
        try await Task.sleep(for: .milliseconds(100))
        finished += 1
    }
}
