import Combine
import XCTest

@testable import ScratchCard

final class ScratchViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()

    func test_ScratchViewModel_OnScratch_ShouldFinishTask() throws {
        let scratch = ScratchCardUseCaseScratchMock()
        let viewModel = viewModel(scratch: scratch)
        let calledExpectation = expectation(description: "called")
        let finishedExpectation = expectation(description: "finished")

        scratch.$called
            .sink { value in
                if value > 0 { calledExpectation.fulfill() }
            }
            .store(in: &cancellables)

        scratch.$finished
            .sink { value in
                if value > 0 { finishedExpectation.fulfill() }
            }
            .store(in: &cancellables)

        viewModel.onScratch()

        wait(for: [calledExpectation, finishedExpectation], timeout: 2.0)

        XCTAssertEqual(scratch.called, 1)
        XCTAssertEqual(scratch.finished, 1)
    }

    func test_ScratchViewModel_OnScratchAndDisappear_ShouldCancelTask() throws {
        let scratch = ScratchCardUseCaseScratchMock()
        let viewModel = viewModel(scratch: scratch)
        let calledExpectation = expectation(description: "called")
        let finishedExpectation = expectation(description: "finished")
        finishedExpectation.isInverted = true

        scratch.$called
            .sink { value in
                if value > 0 { calledExpectation.fulfill() }
            }
            .store(in: &cancellables)

        scratch.$finished
            .sink { value in
                if value > 0 { finishedExpectation.fulfill() }
            }
            .store(in: &cancellables)

        viewModel.onScratch()
        viewModel.onDisappear()

        wait(for: [calledExpectation, finishedExpectation], timeout: 0.5)

        XCTAssertEqual(scratch.called, 1)
        XCTAssertEqual(scratch.finished, 0)
    }
}

fileprivate func viewModel(
    scratch: ScratchCardUseCaseScratch = ScratchCardUseCaseScratchMock()
) -> ScratchViewModel {
    ScratchViewModel(scratch: scratch)
}
