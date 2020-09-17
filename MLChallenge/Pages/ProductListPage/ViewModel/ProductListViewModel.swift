//
//  ProductListViewModel.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

class ProductListViewModel: ProductListViewModelProtocol {
    var _view : ProductListViewProtocol!
    var model : ProductListModel!
    
    required init(withView view: ProductListViewProtocol, items: [ProductItem]) {
        _view = view
        model = ProductListModel(items: items)
    }
    
    func loadItem() {
        _view.showList()
    }
    
    func getItems() -> [ProductItem] {
        return model.items
    }
}

