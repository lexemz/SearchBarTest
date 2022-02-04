//
//  ViewController.swift
//  SearchBarTest
//
//  Created by Igor on 04.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var restaurantImage: UIImageView!
    
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = restaurant.name
        restaurantImage.image = UIImage(named: restaurant.name)
    }
    
}

