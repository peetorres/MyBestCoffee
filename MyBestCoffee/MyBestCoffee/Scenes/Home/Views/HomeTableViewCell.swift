//
//  HomeTableViewCell.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var imageCoffeeShop: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewStarRating: StarRatingView!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Methods
    func setup(with coffeeShop: CoffeeShop) {
        labelName.text = coffeeShop.name
        viewStarRating.rating = coffeeShop.rating
        imageCoffeeShop?.image = UIImage(named: coffeeShop.photo ?? "placeholder")
    }
}
