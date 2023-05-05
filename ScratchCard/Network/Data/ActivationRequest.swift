import Foundation

struct ActivationRequest {
    let urlString = "https://api.o2.sk/version"
    let method = "GET"

    var code: String

    var request: URLRequest? {
        guard var components = URLComponents(string: urlString) else { return nil }
        components.queryItems = [URLQueryItem(name: "code", value: code)]
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
