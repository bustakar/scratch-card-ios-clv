import Combine
import Foundation

final class ScratchCardRepositoryImpl: ScratchCardRepository {

    static let shared = ScratchCardRepositoryImpl()

    private let converter: ActivationNumberDtoConverter
    private let publisher = CurrentValueSubject<Card, Never>(.initial)

    private init(
        converter: ActivationNumberDtoConverter = ActivationNumberDtoConverterImpl()
    ) {
        self.converter = converter
    }

    func store(_ card: Card) {
        self.publisher.send(card)
    }

    func observe() -> AnyPublisher<Card, Never> {
        publisher.eraseToAnyPublisher()
    }

    func load() -> Card {
        publisher.value
    }

    func activate(_ code: UUID) async throws -> Double {
        // TODO: Implement
        return 0.0
    }
}
