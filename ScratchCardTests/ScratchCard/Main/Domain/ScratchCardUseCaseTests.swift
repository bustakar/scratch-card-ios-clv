import XCTest

@testable import ScratchCard

final class ScratchCardUseCaseTests: XCTestCase {

    func test_ScratchCardUseCase_ObserveCard_ShouldObserve() throws {
        let card = Card(secretCode: UUID(), state: .active, isScratched: true)
        var result: Card?
        let repository = ScratchCardRepositoryMock(publisherResult: .init(card))
        let observe = observeCardUseCase(repository: repository)
        let expectation = expectation(description: "observable")

        _ = observe().sink { value in
            result = value
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)

        XCTAssertEqual(repository.observeCalled, 1)
        XCTAssertEqual(card, result)
    }

    func test_ScratchCardUseCase_Scratch_ShouldScratch() async throws {
        let card = Card(secretCode: UUID(), state: .inactive, isScratched: false)
        let repository = ScratchCardRepositoryMock(cardResult: card)
        let scratch = scratchUseCase(repository: repository)
        try await scratch()

        XCTAssertEqual(repository.loadCalled, 1)
        XCTAssertEqual(repository.storeCalled, 1)
        XCTAssertEqual(repository.cardInput?.isScratched, true)
    }

    func test_ScratchCardUseCase_Activate_OnSuccessfulActivationNumber_ShouldActivate() async throws {
        let repository = ScratchCardRepositoryMock(activationCodeResult: 6.5)
        let activate = activateUseCase(repository: repository)
        try await activate()

        XCTAssertEqual(repository.loadCalled, 1)
        XCTAssertEqual(repository.storeCalled, 1)
        XCTAssertEqual(repository.cardInput?.isActivated, true)
    }

    func test_ScratchCardUseCase_Activate_OnFalseActivationNumber_ShouldNotActivate() async throws {
        let repository = ScratchCardRepositoryMock(activationCodeResult: 4.5)
        let activate = activateUseCase(repository: repository)
        try await activate()

        XCTAssertEqual(repository.loadCalled, 1)
        XCTAssertEqual(repository.storeCalled, 0)
        XCTAssertNil(repository.cardInput)
    }
}

fileprivate func observeCardUseCase(
    repository: ScratchCardRepository = ScratchCardRepositoryMock()
) -> ScratchCardUseCaseObserveCard {
    ScratchCardUseCase.ObserveCard(
        repository: repository
    )
}

fileprivate func scratchUseCase(
    repository: ScratchCardRepository = ScratchCardRepositoryMock()
) -> ScratchCardUseCaseScratch {
    ScratchCardUseCase.Scratch(
        repository: repository
    )
}

fileprivate func activateUseCase(
    repository: ScratchCardRepository = ScratchCardRepositoryMock()
) -> ScratchCardUseCaseActivate {
    ScratchCardUseCase.Activate(
        repository: repository
    )
}


