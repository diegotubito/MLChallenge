//
//  SearchViewController.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

class SearchViewController : UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel : SearchViewModelProtocol!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        searchBar.delegate = self
        viewModel = SearchViewModel(withView: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super .prepare(for: segue, sender: sender)
        
        if let destination = segue.destination as? ProductListViewController, let items = sender as? [ProductItem] {
            destination.viewModel = ProductListViewModel(withView: destination, items: items)
        }
    }
}

extension SearchViewController : SearchViewProtocol {
    func getSearchText() -> String {
        return searchBar.text ?? ""
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func showList(items: [ProductItem]) {

        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segue_product_list_vc", sender: items)
        }
        
    }
    
    func showError(_ message: String) {
        print("ERROR: ", message)
    }
    
    
}


extension SearchViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
//    Descomentar para buscar automaticamente cuando el usuario ingresa un caracter.
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.makeSearch(delay: Constant.DelaySearch)
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.searchBar.endEditing(true)
        viewModel.makeSearch(delay: Constant.NoDelaySearch)
    }
}

