//
//  DetailViewcontroller.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

class DetailViewController : UIViewController {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var mercadoPagoImage: UIImageView!
    var viewModel : DetailViewModelProtocol!
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        showProductDetail()
        viewModel.loadImage()
    }
    
    
    func showProductDetail() {
        let selectedItem = viewModel.getSelectedItem()
        titleLabel.text = selectedItem.title
        priceLabel.text = selectedItem.price.currencyFormat(decimal: 2, symbol: Constant.CurrencySymbol)

        if (selectedItem.accepts_mercadopago ?? false) {
            mercadoPagoImage.image = #imageLiteral(resourceName: "logo-mercadopago")
        }
        conditionLabel.text = "Condición: " + (selectedItem.condition ?? "")
    }

}


extension DetailViewController: DetailViewProtocol {
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
    
    func showImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image.image = image
        }
    }
}
