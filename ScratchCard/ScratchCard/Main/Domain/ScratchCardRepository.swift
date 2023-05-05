import Combine
import Foundation

protocol ScratchCardRepository {
    func store(_ card: Card)
    func observe() -> AnyPublisher<Card, Never>
    func load() -> Card
    func activate(_ code: UUID) async throws -> Double
}
