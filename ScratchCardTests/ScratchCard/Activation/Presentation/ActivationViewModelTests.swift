import Combine
import XCTest

@testable import ScratchCard

final class ActivationViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func test_ActivationViewModel_OnActivate_ShouldCallActivate() throws {
        let activate = ScratchCardUseCaseActivateMock()
        let viewModel = viewModel(activate: activate)
        let expectation = expectation(description: "called")

        activate.$called
            .sink { value in
                if value > 0 { expectation.fulfill() }
            }
            .store(in: &cancellables)

        viewModel.onActivate()

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(activate.called, 1)
    }
}

fileprivate func viewModel(
    activate: ScratchCardUseCaseActivate = ScratchCardUseCaseActivateMock()
) -> ActivationViewModel {
    ActivationViewModel(activate: activate)
}
