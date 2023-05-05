import Combine
import Foundation

@testable import ScratchCard

final class NotificationUseCaseDisplayMock: NotificationUseCaseDisplay {

    var called = 0
    var codeInput: String?

    func callAsFunction(_ code: String) {
        called += 1
        codeInput = code
    }
}
