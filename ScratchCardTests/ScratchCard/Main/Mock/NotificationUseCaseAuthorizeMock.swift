import Combine
import Foundation

@testable import ScratchCard

final class NotificationUseCaseAuthorizeMock: NotificationUseCaseAuthorize {

    var called = 0

    func callAsFunction() {
        called += 1
    }
}
