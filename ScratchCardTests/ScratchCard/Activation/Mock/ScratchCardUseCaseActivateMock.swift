import Foundation

@testable import ScratchCard

final class ScratchCardUseCaseActivateMock: ObservableObject, ScratchCardUseCaseActivate {

    @Published var called = 0

    func callAsFunction() async throws {
        called += 1
    }
}
