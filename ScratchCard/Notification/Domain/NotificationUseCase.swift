import Foundation
import UserNotifications

protocol NotificationUseCaseAuthorize {
    func callAsFunction()
}

protocol NotificationUseCaseDisplay {
    func callAsFunction(_ code: String)
}

enum NotificationUseCase {

    class Authorize: NotificationUseCaseAuthorize {

        func callAsFunction() {
            UNUserNotificationCenter.current().requestAuthorization(options: [
                .alert,
                .badge,
                .sound
            ]) { _,_ in }
        }
    }

    class Display: NotificationUseCaseDisplay {

        func callAsFunction(_ code: String) {
            let content = UNMutableNotificationContent()
            content.title = "Error activating scratch card"
            content.subtitle = "Code: \(code)"
            content.sound = .default
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 1,
                repeats: false
            )
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            UNUserNotificationCenter.current().add(request)
        }
    }
}
