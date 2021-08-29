//
//  HomeViewModel.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import Alamofire
import Foundation

final class HomeViewModel {
    // MARK: Properties
    private(set) var coffeeShops: [CoffeeShop]?
    
    // MARK: Methods
    
    // MARK: Services
    func getCoffeeShopsService() {
        AF.request("https://demo2936449.mockable.io/coffee-shop").response { [weak self] response in
            switch response.result {
            case .success(let response):
                guard let response = response else { return }
                self?.coffeeShops = NetworkParse.JSONDecodable(to: [CoffeeShop].self, from: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
