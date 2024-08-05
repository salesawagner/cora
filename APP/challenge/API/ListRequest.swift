//
//  ListRequest.swift
//  challenge
//
//  Created by Wagner Sales
//

import API

struct ListRequest: APIRequest {
    typealias Response = ListResponse

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "list"
    }
}
