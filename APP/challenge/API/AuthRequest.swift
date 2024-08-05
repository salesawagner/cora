//
//  AuthRequest.swift
//  challenge
//
//  Created by Wagner Sales on
//

import API

struct AuthRequest: APIRequest {
    typealias Response = AuthResponse

    var httpMethod: APIHTTPMethod {
        .post
    }

    var resourceName: String {
        "auth"
    }

    let cpf: String
    let password: String
}
