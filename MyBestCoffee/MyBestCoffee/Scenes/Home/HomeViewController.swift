//
//  HomeViewController.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: Properties
    private var progressView: ProgressView?
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
    @objc
    func switchDidChange(sender: UISwitch!) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        keyWindow?.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
    }
    
    // MARK: Methods
    private func bindEvents() {
        viewModel.handleSuccess = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.handleFailure = { [weak self] message in
            self?.showAlert(with: message)
        }
        
        viewModel.shouldProgress = { [weak self] isShowing in
            isShowing ? self?.showProgress() : self?.dismissProgress()
        }
    }
    
    private func setupUI() {
        title = "My Best Coffee"
        setupTableView()
        setupNavigationBarSwitch()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 250
    }
}

// MARK: Base Controller Methods
extension HomeViewController {
    private func showProgress() {
        progressView = .fromNib()
        guard let progressView = progressView else { return }
        view.endEditing(true)
        view.addSubview(progressView)
        progressView.frame = view.bounds
    }
    
    private func dismissProgress() {
        progressView?.removeFromSuperview()
        progressView = nil
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
    
    private func setupNavigationBarSwitch() {
        let switchControl = UISwitch()
        let isDarkMode = traitCollection.userInterfaceStyle != .light
        switchControl.setOn(isDarkMode, animated: false)
        switchControl.addTarget(self, action: #selector(switchDidChange(sender:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: switchControl)
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
