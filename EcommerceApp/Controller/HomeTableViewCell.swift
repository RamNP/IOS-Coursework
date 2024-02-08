//
//  HomeTableViewCell.swift
//  EcommerceApp
//
//  Created by Student on 27/01/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var category: UILabel!

    @IBOutlet weak var imgView: UIImageView!
    private var products: [Product] = []

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
                    self.imgView.image = image
                }
            }
        }.resume()
    }
    
    
   
}
