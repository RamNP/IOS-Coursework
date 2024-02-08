//
//  ProductServices.swift
//  EcommerceApp
//
//  Created by Student on 27/01/2024.
//

import Foundation

class ProductService {
    static let shared = ProductService()

     init() {}

    func getProducts(completion: @escaping (Result<ProductsResponse, Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let productsResponse = try decoder.decode(ProductsResponse.self, from: data)
                completion(.success(productsResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
