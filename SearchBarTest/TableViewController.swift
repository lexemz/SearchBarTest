//
//  TableViewController.swift
//  SearchBarTest
//
//  Created by Igor on 04.02.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let restaurants = Restaurant.getRestaurants()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        viewController.restaurant = restaurants[indexPath.row]
    }
}

extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let restaurant = restaurants[indexPath.row]
        
        content.text = restaurant.name
        content.secondaryText = restaurant.type.rawValue
        
        cell.contentConfiguration = content
        return cell
    }
}
