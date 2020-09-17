//
//  ProductListViewController.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

class ProductListViewController : UIViewController {
  
    var productListContainer: ProductListView!
    var viewModel : ProductListViewModelProtocol!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        createProductListView()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        viewModel.loadItem()
    }
    
    private func createProductListView() {
        productListContainer = ProductListView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(productListContainer)
        productListContainer.onSelectionItem = { item in
            self.routeToDetailVC(withProduct: item)
        }
    }
    
    private func routeToDetailVC(withProduct: ProductItem) {
        performSegue(withIdentifier: "segue_to_detail_vc", sender: withProduct)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super .prepare(for: segue, sender: sender)
        
        if let vc = segue.destination as? DetailViewController {
            if let item = sender as? ProductItem {
                vc.viewModel = DetailViewModel(withView: vc, selectedItem: item)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let animationHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            self?.productListContainer.removeFromSuperview()
            self?.createProductListView()
        }

        let completionHandler: ((UIViewControllerTransitionCoordinatorContext) -> Void) = { [weak self] (context) in
            self?.viewModel.loadItem()
        }

        coordinator.animate(alongsideTransition: animationHandler, completion: completionHandler)
   }
}

extension ProductListViewController : ProductListViewProtocol {
    func showList() {
        let items = viewModel.getItems()
        productListContainer.startLoading(products: items)
    }
}

