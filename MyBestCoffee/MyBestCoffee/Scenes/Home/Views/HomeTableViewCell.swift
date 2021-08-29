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
    @IBOutlet weak var labelRating: UILabel!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Methods
}
