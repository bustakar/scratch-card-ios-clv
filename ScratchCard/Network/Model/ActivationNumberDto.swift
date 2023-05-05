import Foundation

struct ActivationNumberDto: Codable {
    var activationNumberDto: String

    enum CodingKeys: String, CodingKey {
        case activationNumberDto = "ios"
    }
}

