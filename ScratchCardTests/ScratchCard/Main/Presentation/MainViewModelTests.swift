import XCTest

@testable import ScratchCard

final class MainViewModelTests: XCTestCase {

    func test_MainViewModel_OnInit_ShouldObserveCard() throws {
        let card = Card(secretCode: UUID(), state: .active, isScratched: true)
        let observe = ScratchCardUseCaseObserveCardMock(result: .init(card))
        _ = viewModel(observeCard: observe)

        XCTAssertEqual(observe.called, 1)
    }

    func test_MainViewModel_OnAppear_ShouldAuthorizeNotifications() throws {
        let authorize = NotificationUseCaseAuthorizeMock()
        let viewModel = viewModel(authorizeNotifications: authorize)

        viewModel.onAppear()

        XCTAssertEqual(authorize.called, 1)
    }
}

fileprivate func viewModel(
    authorizeNotifications: NotificationUseCaseAuthorize = NotificationUseCaseAuthorizeMock(),
    observeCard: ScratchCardUseCaseObserveCard = ScratchCardUseCaseObserveCardMock()
) -> MainViewModel {
    MainViewModel(
        authorizeNotifications: authorizeNotifications,
        observeCard: observeCard
    )
}
