//
//  APIRequest.swift
//  API
//
//  Created by Wagner Sales
//

import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable

    var httpMethod: APIHTTPMethod { get }
    var resourceName: String { get }
}
