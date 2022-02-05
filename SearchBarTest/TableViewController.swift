//
//  TableViewController.swift
//  SearchBarTest
//
//  Created by Igor on 04.02.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let restaurants = Restaurant.getRestaurants()
    
    private var filtredRestaurants: [Restaurant] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        setupSearchController()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let restaurant: Restaurant
        
        if isFiltering {
            restaurant = filtredRestaurants[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        
        viewController.restaurant = restaurant
    }
    
    private func setupSearchController() {
        // Данное свойство подписано под протокол UISearchResultsUpdating
        // Передавая сам экземпляр класса в свойство, получателем информации из поисковой строки становится сам класс
        searchController.searchResultsUpdater = self
        
        // По умолчанию VC с результатами поиска не позволяет взаимодействовать с контентом
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Type Restaurant"
        
        navigationItem.searchController = searchController
        
        // Отпустить строку поиска при переходе на другой экран
        definesPresentationContext = true
    }
}

// MARK: - TableView data source
extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredRestaurants.count
        }
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let restaurant: Restaurant
        
        if isFiltering {
            restaurant = filtredRestaurants[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        
        content.text = restaurant.name
        content.secondaryText = restaurant.type.rawValue
        
        cell.contentConfiguration = content
        return cell
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filtredRestaurants = restaurants.filter { restaurant in
            restaurant.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}
