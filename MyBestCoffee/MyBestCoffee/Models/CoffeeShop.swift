//
//  CoffeeShop.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import Foundation

struct CoffeeShop: Codable {
    let name: String
    let address: String
    let photo: String?
    let rating: Float
    let user_ratings_total: Int
    let open_now: Bool
}
