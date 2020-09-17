//
//  SearchViewModel.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

class SearchViewModel : SearchViewModelProtocol {
    var _view : SearchViewProtocol!
    var model : SearchModel!
    var service : ServiceManager!
    var timer : Timer?
    
    required init(withView view: SearchViewProtocol) {
        service = ServiceManager()
        model = SearchModel()
        _view = view
    }
    
    func makeSearch(delay: TimeInterval) {
        model.searchText = _view.getSearchText()
        model.elapsedTime = delay
        searchWithSchedule()
    }
   
    private func searchWithSchedule() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: model.elapsedTime, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: false)
    }
    
    @objc private func timerHandler() {
        search()
    }
    
    private func search() {
        _view.showLoading()
        let url = Constant.URL.baseURL_search + model.searchText
        service.retrieveData(stringURL: url) { [weak self] (data, serviceError) in
            self?._view.hideLoading()
            guard serviceError == nil else {
                self?._view.showError(serviceError?.rawValue ?? ServiceError.unknown.rawValue)
                return
            }
            do {
                //  at this point, data is not nil.
                let products = try JSONDecoder().decode(Product.self, from: data!)
                self?.model.products = products
                let items = products.results
                self?._view.showList(items: items)
            } catch {
                self?.model.products = nil
                self?._view.showError(ServiceError.decode.rawValue)
            }
        }
    }
}

