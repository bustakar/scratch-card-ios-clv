import Combine
import Foundation

@testable import ScratchCard

final class ScratchCardUseCaseObserveCardMock: ScratchCardUseCaseObserveCard {

    var called = 0
    private var result: CurrentValueSubject<Card, Never>

    init(result: CurrentValueSubject<Card, Never> = .init(.initial)) {
        self.result = result
    }

    func callAsFunction() -> AnyPublisher<Card, Never> {
        called += 1
        return result.eraseToAnyPublisher()
    }
}
