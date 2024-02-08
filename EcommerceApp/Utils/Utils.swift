//
//  Utils.swift
//  EcommerceApp
//
//  Created by Student on 30/01/2024.
//

import UIKit

class Utils {
    
    func showToastMessage(controller: UIViewController, message : String, seconds: Double) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.view.backgroundColor = UIColor.black
            alert.view.alpha = 0.6
            alert.view.layer.cornerRadius = 15
            
            controller.present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
            }
        }
    }
}
