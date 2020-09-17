//
//  GeneralModel.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import Foundation

struct Product : Decodable {
    var query : String
    var results : [ProductItem]
}

struct ProductItem : Decodable {
    var title : String
    var price : Double
    var thumbnail : String?
    var condition : String?
    var available_quantity : Int?
    var accepts_mercadopago : Bool?
}

