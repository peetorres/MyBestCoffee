//
//  DetailsViewController.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: Properties
    private let coffeeShop: CoffeeShop
    
    // MARK: Outlets
    @IBOutlet weak var imageCoffeeShop: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOpenStatus: UILabel!
    @IBOutlet weak var viewOpenStatus: CustomView!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var viewStarRating: StarRatingView!
    @IBOutlet weak var labelUserRatings: UILabel!
    
    // MARK: Initializers
    init(coffeeShop: CoffeeShop) {
        self.coffeeShop = coffeeShop
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coffee Shop Details"
        setupUI()
    }
    
    // MARK: Actions
    
    // MARK: Methods
    private func setupUI() {
        imageCoffeeShop.image = UIImage(named: coffeeShop.photo ?? "placeholder")
        labelName.text = coffeeShop.name
        labelAddress.text = "Address: " + coffeeShop.address
        labelRating.text = "Rating: \(coffeeShop.rating)"
        labelUserRatings.text = "User Ratings Total: \(coffeeShop.user_ratings_total)"
        viewOpenStatus.backgroundColor = coffeeShop.open_now ? .green : .red
        labelOpenStatus.text =  "The place is \(coffeeShop.open_now ? "open" : "closed") now"
    }
}
