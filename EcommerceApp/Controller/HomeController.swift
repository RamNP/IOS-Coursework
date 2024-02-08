//
//  ViewController.swift
//  EcommerceApp
//
//  Created by Student on 26/01/2024.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate ,UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!


    
    @IBOutlet weak var searchButton: UIButton!
    private var products: [Product] = []
    private var filteredProducts: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchButton.addTarget(self, action: #selector(searchButtontapped), for: .touchUpInside)

        ProductService.shared.getProducts { [weak self] result in
            switch result {
            case .success(let productsResponse):
                self?.products = productsResponse.products
                self?.filteredProducts = self?.products ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }

            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }
    
    @objc func searchButtontapped(){
        if let searchText = searchBar.text{
            filterProductsByCategory(searchText)
        }
        searchBar.resignFirstResponder()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let product = filteredProducts[indexPath.row]
        cell.loadData(imgUrl: product.thumbnail)
        cell.title.text = product.title
        cell.price.text = String(format: "%.1f", product.price)
        cell.category.text = product.category

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = filteredProducts[indexPath.row]
        // Handle the selected product as needed (e.g., navigate to a details screen).
        print("Selected Product: \(selectedProduct.id)")
        print("Selected Product: \(selectedProduct.title)")
        print("Selected Product: \(selectedProduct.price)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("before")
        let productDetailsVC = storyboard.instantiateViewController(withIdentifier: "ProductdetailsController") as! ProductdetailsController
        print("before")

        productDetailsVC.productIndex = indexPath.row

        self.present(productDetailsVC, animated: true, completion: nil)


        
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterProductsByCategory(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        filterProductsByCategory("")
    }

    func filterProductsByCategory(_ searchText: String) {
        if searchText.isEmpty {
            // If the search text is empty, show all products
            filteredProducts = products
        } else {
            // Filter products based on title or category containing the search text (case-insensitive)
            filteredProducts = products.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.category.lowercased().contains(searchText.lowercased())
            }
        }
        // Reload the table view to reflect the changes
        tableView.reloadData()
    }
    

    
}
