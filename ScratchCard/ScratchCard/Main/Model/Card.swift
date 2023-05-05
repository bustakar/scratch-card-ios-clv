import Foundation

struct Card: Equatable {
    enum State: Equatable {
        case active, inactive
    }

    var secretCode = UUID()
    var state: State
    var isScratched: Bool
    var isActivated: Bool {
        state == .active
    }
}

extension Card {
    static var initial: Card {
        Card(state: .inactive, isScratched: false)
    }
}
