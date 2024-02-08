//
//  ProductdetailsController.swift
//  EcommerceApp
//
//  Created by Student on 30/01/2024.
//

import UIKit

class ProductdetailsController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var disprice: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var brandLabel: UILabel!
    let productServices = ProductService()
    private var products: [Product] = []
    var productIndex: Int = 0
    private var filteredProducts: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apiCall()
    }
    
    func loadData(imgUrl:String){
        if let imageUrl = URL(string: imgUrl){
            downloadImage(from: imageUrl)
        }
    }

    func downloadImage(from url: URL){
        URLSession.shared.dataTask(with: url){data, response, error in
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.ImageView.image = image
                }
            }
        }.resume()
    }
    
}

extension ProductdetailsController{
    private func apiCall(){
        ProductService.shared.getProducts { [weak self] result in
            switch result {
            case .success(let productsResponse):
                self?.products = productsResponse.products
                self?.filteredProducts = self?.products ?? []
                DispatchQueue.main.async {
                    self?.loadData(imgUrl: self?.products[self?.productIndex ?? 0].thumbnail ?? "")
                    self?.idLabel.text = "\(self?.products[self?.productIndex ?? 0].id ?? 0 )"
                    self?.titleLabel.text = self?.products[self?.productIndex ?? 0].title
                    self?.descriptionLabel.text = self?.products[self?.productIndex ?? 0].description
                    self?.priceLabel.text = "\(self?.products[self?.productIndex ?? 0].price ?? 0)"
                    self?.disprice.text = "\(self?.products[self?.productIndex ?? 0].discountPercentage ?? 0)"
                    self?.stockLabel.text = "\(self?.products[self?.productIndex ?? 0].stock ?? 0)"
                    self?.brandLabel.text = self?.products[self?.productIndex ?? 0].brand
                    self?.categoryLabel.text = self?.products[self?.productIndex ?? 0].category



                
                }

            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }
    
}
