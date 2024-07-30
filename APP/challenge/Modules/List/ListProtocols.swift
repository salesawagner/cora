//
//  ListProtocols.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

protocol ListInputProtocol {
    var viewController: ListOutputProtocol? { get set }
    var sections: [ListSectionViewModel] { get }
    func didSelectRow(indexPath: IndexPath)
    func didTapReload()
    func pullToRefresh()
    func viewDidLoad()
}

protocol ListOutputProtocol {
    func startLoading()
    func success()
    func failure()
}
