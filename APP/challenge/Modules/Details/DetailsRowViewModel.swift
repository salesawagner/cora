//
//  DetailsRowViewModel.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

enum DetailsRowViewModel {
    case icon(named: String, title: String)
    case amount(title: String, value: String)
    case date(title: String, value: String)
    case recipient(title: String, bankName: String, documentNumber: String, name: String, account: String)
    case description(title: String, value: String)
}
