//
//  ProductListView.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

class ProductListView: GenericTableView<ProductListTableViewCell, ProductItem> {
    override func commonInit() {
        super .commonInit()
        automaticRowHeight = true
        
    }
    
    func startLoading(products: [ProductItem]) {
        items = products
        tableView.reloadData()
    }
}

