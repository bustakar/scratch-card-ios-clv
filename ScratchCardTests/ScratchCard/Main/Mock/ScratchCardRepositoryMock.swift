import Combine
import Foundation

@testable import ScratchCard

final class ScratchCardRepositoryMock: ScratchCardRepository {

    var storeCalled = 0
    var observeCalled = 0
    var loadCalled = 0
    var activateCalled = 0

    var cardInput: Card?
    var codeInput: UUID?

    private var cardResult: Card
    private var publisherResult: CurrentValueSubject<Card, Never>
    private var activationCodeResult: Double

    init(
        cardResult: Card = .initial,
        publisherResult: CurrentValueSubject<Card, Never> = .init(.initial),
        activationCodeResult: Double = 6.1
    ) {
        self.cardResult = cardResult
        self.publisherResult = publisherResult
        self.activationCodeResult = activationCodeResult
    }

    func store(_ card: Card) {
        storeCalled += 1
        cardInput = card
    }

    func observe() -> AnyPublisher<Card, Never> {
        observeCalled += 1
        return publisherResult.eraseToAnyPublisher()
    }

    func load() -> Card {
        loadCalled += 1
        return cardResult
    }

    func activate(_ code: UUID) async throws -> Double {
        activateCalled += 1
        return activationCodeResult
    }
}
