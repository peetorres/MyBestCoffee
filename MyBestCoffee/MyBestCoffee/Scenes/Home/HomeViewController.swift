//
//  HomeViewController.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: Properties
    private var viewModel: HomeViewModel = .init()
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindEvents()
        viewModel.getCoffeeShopsService()
    }
    
    // MARK: Actions
    
    // MARK: Methods
    private func bindEvents() {
        viewModel.handleSuccess = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.handleFailure = { [weak self] message in
            self?.showAlert(with: message)
        }
        
        viewModel.shouldProgress = { [weak self] isShowing in
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.startAnimating()
            self?.view.addSubview(activityIndicator)
        }
    }
    
    private func setupUI() {
        title = "My Best Coffee"
        setupTableView()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 235
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Something went wrong", message: message, preferredStyle: .alert)
        let tryAgainButton = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.viewModel.getCoffeeShopsService()
        }
        alert.addAction(tryAgainButton)
        present(alert, animated: true, completion: nil)
    }
    
    private func instanceDetails(of coffeeShop: CoffeeShop) {
        let viewController = DetailsViewController(coffeeShop: coffeeShop)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coffeeShops?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell
        if let coffeeShop = viewModel.coffeeShops?[indexPath.row] {
            cell?.setup(with: coffeeShop)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let coffeeShop = viewModel.coffeeShops?[indexPath.row] else { return }
        instanceDetails(of: coffeeShop)
    }
}
