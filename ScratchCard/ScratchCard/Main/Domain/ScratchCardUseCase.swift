import Combine
import Foundation

protocol ScratchCardUseCaseObserveCard {
    func callAsFunction() -> AnyPublisher<Card, Never>
}

protocol ScratchCardUseCaseScratch {
    func callAsFunction() async throws
}

protocol ScratchCardUseCaseActivate {
    func callAsFunction() async throws
}

enum ScratchCardUseCase {

    class ObserveCard: ScratchCardUseCaseObserveCard {

        private let repository: ScratchCardRepository

        init(repository: ScratchCardRepository) {
            self.repository = repository
        }

        func callAsFunction() -> AnyPublisher<Card, Never> {
            repository.observe()
        }
    }

    class Scratch: ScratchCardUseCaseScratch {

        private let repository: ScratchCardRepository

        init(repository: ScratchCardRepository) {
            self.repository = repository
        }

        func callAsFunction() async throws {
            try await Task.sleep(for: .seconds(2))
            var card = repository.load()
            card.isScratched = true
            repository.store(card)
        }
    }

    class Activate: ScratchCardUseCaseActivate {

        private let repository: ScratchCardRepository

        init(repository: ScratchCardRepository) {
            self.repository = repository
        }

        func callAsFunction() async throws {
            var card = repository.load()
            let activationNumber = try await repository.activate(card.secretCode)
            if activationNumber > 6.1 {
                card.state = .active
                repository.store(card)
            } 
        }
    }
}
