//
//  DetailsRequest.swift
//  challenge
//
//  Created by Wagner Sales on 31/07/24.
//

import API

struct DetailsRequest: APIRequest {
    typealias Response = DetailsResponse

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "details/\(id)"
    }

    @SkipBody var id: String
}
