import Combine
import Foundation

final class ScratchCardRepositoryImpl: ScratchCardRepository {

    static let shared = ScratchCardRepositoryImpl()

    private let apiRequest: NetworkUseCaseRequest
    private let converter: ActivationNumberDtoConverter
    private let publisher = CurrentValueSubject<Card, Never>(.initial)

    private init(
        apiRequest: NetworkUseCaseRequest = NetworkUseCase.Request(),
        converter: ActivationNumberDtoConverter = ActivationNumberDtoConverterImpl()
    ) {
        self.apiRequest = apiRequest
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
        guard let request = ActivationRequest(code: code.uuidString).request else {
            throw NetworkError.failedToCreateRequest
        }
        let data = try await apiRequest(request)
        let dto = try JSONDecoder().decode(ActivationNumberDto.self, from: data)
        let activationNumber = try converter.toDomain(dto)
        return activationNumber
    }
}
