//
//  ListResponse.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

// MARK: - ListResponse
struct ListResponse: Codable {
    let results: [Result]
    let itemsTotal: Int
}

// MARK: - Result
struct Result: Codable {
    let items: [Item]
    let date: String
}

enum EntryType: String, Codable {
    case debit = "DEBIT"
    case credit = "CREDIT"
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let description: String
    let label: String
    let entry: EntryType
    let amount: Double
    let name: String
    let dateEvent: String
    let status: String
}
