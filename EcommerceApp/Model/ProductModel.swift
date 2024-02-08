//
//  ProductModel.swift
//  EcommerceApp
//
//  Created by Student on 27/01/2024.
//

import Foundation

class Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, description, price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
}

class ProductsResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
