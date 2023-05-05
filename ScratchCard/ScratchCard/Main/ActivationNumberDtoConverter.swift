import Foundation

enum ConversionError: Error {
    case failedToConvert
}

protocol ActivationNumberDtoConverter {
    func toDomain(_ dto: String) throws -> Double
}

final class ActivationNumberDtoConverterImpl: ActivationNumberDtoConverter {

    func toDomain(_ dto: String) throws -> Double {
        let components = dto.components(separatedBy: ".")
        guard components.count >= 2,
              let number = Double("\(components[0]).\(components[1])") else {
            throw ConversionError.failedToConvert
        }
        return number
    }
}
