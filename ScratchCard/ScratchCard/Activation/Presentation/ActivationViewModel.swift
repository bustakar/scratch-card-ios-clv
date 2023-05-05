import Foundation

class ActivationViewModel: ObservableObject {

    private let activate: ScratchCardUseCaseActivate

    init(activate: ScratchCardUseCaseActivate = ScratchCardUseCase.Activate()) {
        self.activate = activate
    }

    func onActivate() {
        Task {
            try await activate()
        }
    }
}
