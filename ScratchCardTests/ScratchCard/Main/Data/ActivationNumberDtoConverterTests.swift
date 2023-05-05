import XCTest

@testable import ScratchCard

final class ActivationNumberDtoConverterTests: XCTestCase {

    func test_ActivationNumberDtoConverter_ShouldSucceed() throws {
        let dto = ActivationNumberDto(activationNumberDto: "6.1.6")
        let converter = ActivationNumberDtoConverterImpl()

        let activationNumber = try converter.toDomain(dto)

        XCTAssertEqual(activationNumber, 6.1)
    }

    func test_ActivationNumberDtoConverter_OnWrongFormat_ShouldFail() throws {
        let dto = ActivationNumberDto(activationNumberDto: "6.a.6")
        let converter = ActivationNumberDtoConverterImpl()

        XCTAssertThrowsError(try converter.toDomain(dto))
    }

    func test_ActivationNumberDtoConverter_OnShortResponse_ShouldFail() throws {
        let dto = ActivationNumberDto(activationNumberDto: "6")
        let converter = ActivationNumberDtoConverterImpl()

        XCTAssertThrowsError(try converter.toDomain(dto))
    }
}
