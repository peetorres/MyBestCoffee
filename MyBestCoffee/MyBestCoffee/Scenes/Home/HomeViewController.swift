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
    @IBOutlet weak var tableView: UITableView!
    
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
        setupTableView()
        view.backgroundColor = .brown
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 230
    }
}

// MARK: Extensions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell
        cell?.labelName.text = "Coffee Name"
        cell?.labelRating.text = "Rating: 5 Stars"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row \(indexPath.row)")
    }
}
