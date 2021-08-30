//
//  ProgressView.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import UIKit
import Lottie

final class ProgressView: UIView {
    // MARK: Outlets
    @IBOutlet weak var animationView: AnimationView!

    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLottie()
    }
    
    // MARK: Methods
    private func setupLottie() {
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
    }
}
