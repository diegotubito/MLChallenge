//
//  ProductListTableViewCell.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

class ProductListTableViewCell: GenericTableViewCell<ProductItem, ServiceManager> {
    @IBOutlet weak var imageLodingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    override func awakeFromNib() {
        super .awakeFromNib()
        service = ServiceManager()
    }
    
    override var item : ProductItem? {
        didSet {
            titleLabel.text = item?.title
            priceLabel.text = item?.price.currencyFormat(decimal: 2, symbol: "$")
            loadImage()
        }
    }
    
    private func loadImage() {
        
        if let imageFromCache = imageCache.object(forKey: item?.thumbnail as AnyObject) as? UIImage {
            print("image loaded from cache")
            showImage(imageFromCache)
            return
        }
        guard let thumbnailURL = item?.thumbnail else {
            return
        }
        
        showLoading()
        service?.downloadImageFromUrl(url: thumbnailURL, result: { [weak self] (data, url) in
            self?.hideLoading()
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            let imageToCache = image
            self?.imageCache.setObject(imageToCache, forKey: url as AnyObject)
            if self?.item?.thumbnail == url {
                self?.showImage(image)
            }
        }) { [weak self] (error, message) in
            self?.hideLoading()
            print(message)
        }
    }
    
    private func hideLoading() {
        DispatchQueue.main.async {
            self.imageLodingIndicator.stopAnimating()
        }
    }
    
    private func showLoading() {
        DispatchQueue.main.async {
            self.imageLodingIndicator.startAnimating()
        }
    }
    
    private func showImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.productImage.image = image
        }
    }
}
