import API

struct AuthRequest: APIRequest {
    typealias Response = AuthResponse

    var httpMethod: APIHTTPMethod {
        .post
    }

    var resourceName: String {
        "auth"
    }
}
