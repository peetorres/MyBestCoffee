//
//  HomeViewController.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: Properties
    var viewModel: HomeViewModel = .init()
    
    // MARK: Outlets
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getCoffeeShopsService()
    }
    
    // MARK: Actions
    
    // MARK: Methods
    private func setupUI() {
        title = "My Best Coffee"
        view.backgroundColor = .brown
    }
}
