import Combine
import Foundation

class MainViewModel: ObservableObject {

    private let authorizeNotifications: NotificationUseCaseAuthorize
    private let observeCard: ScratchCardUseCaseObserveCard
    private var cancellable: AnyCancellable?

    @Published var card: Card = .initial

    var isScratchButtonDisabled: Bool {
        card.isScratched
    }

    var isActivateButtonDisabled: Bool {
        !card.isScratched || card.isActivated
    }

    var isActivated: Bool {
        card.state == .active
    }

    

    init(
        authorizeNotifications: NotificationUseCaseAuthorize = NotificationUseCase.Authorize(),
        observeCard: ScratchCardUseCaseObserveCard = ScratchCardUseCase.ObserveCard()
    ) {
        self.authorizeNotifications = authorizeNotifications
        self.observeCard = observeCard

        setup()
    }

    private func setup() {
        cancellable = observeCard()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] receivedValue in
                self?.card = receivedValue
            }
    }

    func onAppear() {
        authorizeNotifications()
    }
}
