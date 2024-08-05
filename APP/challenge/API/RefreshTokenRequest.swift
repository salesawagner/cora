//
//  RefreshTokenRequest.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

struct RefreshTokenRequest: APIRequest {
    typealias Response = AuthResponse

    var httpMethod: APIHTTPMethod {
        .post
    }

    var resourceName: String {
        "auth"
    }

    let token: String
}


