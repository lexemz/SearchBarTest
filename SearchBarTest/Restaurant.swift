//
//  Restaurant.swift
//  SearchBarTest
//
//  Created by Igor on 04.02.2022.
//

import Foundation

struct Restaurant {
    let name: String
    let type: RestaurantType
    
    static func getRestaurants() -> [Restaurant] {
        [
            Restaurant(name: "Abobus", type: .bar),
            Restaurant(name: "Takeda", type: .bar),
            Restaurant(name: "Aeda", type: .restaurant),
            Restaurant(name: "McDonalds", type: .fastfood),
            Restaurant(name: "KFC ", type: .fastfood),
            Restaurant(name: "Izumi", type: .bar)
        ]
    }
}

enum RestaurantType: String {
    case restaurant
    case fastfood
    case bar
}
