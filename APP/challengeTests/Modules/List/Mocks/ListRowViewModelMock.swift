//
//  ListRowViewModelMock.swift
//  challengeTests
//
//  Created by Wagner Sales
//

@testable import challenge

extension ListSectionViewModel {
    static var mock: ListSectionViewModel {
        .init(date: "2024-05-05", rows: [
            .init(id: "", entryType: .credit, amount: "", dateEvent: "", name: "", description: "")
        ])
    }
}

extension Array where Element == ListSectionViewModel {
    static var mock: [ListSectionViewModel] {
        [.mock]
    }
}
