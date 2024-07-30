//
//  ListRowViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

struct ListSectionViewModel {
    let date: String
    let rows: [ListRowViewModel]
}

struct ListRowViewModel {
    let id: String
    let entryType: EntryType
    let amount: String
    let dateEvent: String
    let name: String
    let description: String
}
