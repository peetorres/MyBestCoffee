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
    var handleSuccess: (() -> Void)?
    var handleFailure: ((String) -> Void)?
    var shouldProgress: ((Bool) -> Void)?
    
    // MARK: Methods
    private func handleDecode(of response: Data?) {
        if let coffeShops = NetworkParse.JSONDecodable(
            to: [CoffeeShop].self, from: response!) {
            self.coffeeShops = coffeShops
            handleSuccess?()
        } else {
            handleFailure?("Contact to app provider.")
        }
    }
    
    // MARK: Services
    func getCoffeeShopsService() {
        shouldProgress?(true)
        AF.request("https://demo2936449.mockable.io/coffee-shop").response { [weak self] response in
            self?.shouldProgress?(false)
            switch response.result {
            case .success(let response):
                self?.handleDecode(of: response)
            case .failure(let error):
                self?.handleFailure?(error.localizedDescription)
            }
        }
    }
}
