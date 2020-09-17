//
//  ProductListViewModelProtocol.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

protocol ProductListViewModelProtocol {
    init(withView view: ProductListViewProtocol, items: [ProductItem])
    func loadItem()
    func getItems() -> [ProductItem]
}

protocol ProductListViewProtocol {
    func showList()
}

