//
//  DetailsResponse.swift
//  challenge
//
//  Created by Wagner Sales on 31/07/24.
//

import Foundation

// MARK: - DetailsResponse
struct DetailsResponse: Codable {
    let description: String
    let label: String
    let amount: Double
    let counterPartyName: String
    let id: String
    let dateEvent: String
    let recipient: Recipient
    let sender: Recipient
    let status: String
}

// MARK: - Recipient
struct Recipient: Codable {
    let bankName: String
    let bankNumber: String
    let documentNumber: String
    let documentType: String
    let accountNumberDigit: String
    let agencyNumberDigit: String
    let agencyNumber: String
    let name: String
    let accountNumber: String
}
