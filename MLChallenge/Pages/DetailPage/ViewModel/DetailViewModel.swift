//
//  DetailViewModel.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

protocol DetailViewModelProtocol {
    init(withView view: DetailViewProtocol, selectedItem: ProductItem)
    func getSelectedItem() -> ProductItem
    func loadImage()
}

protocol DetailViewProtocol {
    func showLoading()
    func hideLoading()
    func showImage(_ image: UIImage)
}


