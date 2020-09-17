//
//  SearchViewModelProtocol.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

protocol SearchViewModelProtocol {
    init(withView view: SearchViewProtocol)
    func makeSearch(delay: TimeInterval)
}

protocol SearchViewProtocol {
    func showLoading()
    func hideLoading()
    func showList(items: [ProductItem])
    func showError(_ message: String)
    func getSearchText() -> String
}


