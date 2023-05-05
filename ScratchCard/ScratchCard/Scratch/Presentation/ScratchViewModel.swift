import Foundation

class ScratchViewModel: ObservableObject {

    private let scratch: ScratchCardUseCaseScratch
    private var task: Task<(), Error>?

    init(scratch: ScratchCardUseCaseScratch = ScratchCardUseCase.Scratch()) {
        self.scratch = scratch
    }

    func onScratch() {
        task = Task {
            try await scratch()
        }
    }

    func onDisappear() {
        task?.cancel()
    }
}
