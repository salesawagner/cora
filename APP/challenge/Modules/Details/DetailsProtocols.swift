//
//  DetailsProtocols.swift
//  challenge
//
//  Created by Wagner Sales
//

import Foundation

protocol DetailsInputProtocol {
    var viewController: DetailsOutputProtocol? { get set }
    var rows: [DetailsRowViewModel] { get }
    func didTapReload()
    func pullToRefresh()
    func viewDidLoad()
}

protocol DetailsOutputProtocol {
    func startLoading()
    func success()
    func failure()
}
