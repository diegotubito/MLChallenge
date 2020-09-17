//
//  DetailViewModelProtocol.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

class DetailViewModel : DetailViewModelProtocol {
    var _view : DetailViewProtocol
    var model : DetailModel!
    
    required init(withView view: DetailViewProtocol, selectedItem: ProductItem) {
        _view = view
        model = DetailModel(selectedItem: selectedItem)
    }
    
    func getSelectedItem() -> ProductItem {
        return model.selectedItem
    }
    
    func loadImage() {
        let item = model.selectedItem
        guard let thumbnailURL = item.thumbnail else {
            return
        }
        
        _view.showLoading()
        let service = ServiceManager()
        service.downloadImageFromUrl(url: thumbnailURL, result: { [weak self] (data, url) in
            self?._view.hideLoading()
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            self?._view.showImage(image)
        }) { [weak self] (error, message) in
            self?._view.hideLoading()
            print(message)
        }
    }
}


