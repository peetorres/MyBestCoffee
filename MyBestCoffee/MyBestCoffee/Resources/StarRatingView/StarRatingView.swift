//
//  StarRatingView.swift
//
//  Created by Guido on 7/1/20.
//  Copyright © applified.life - All rights reserved.
//

import UIKit

public enum StarRounding: Int {
    case roundToHalfStar = 0
    case ceilToHalfStar = 1
    case floorToHalfStar = 2
    case roundToFullStar = 3
    case ceilToFullStar = 4
    case floorToFullStar = 5
}

@IBDesignable
class StarRatingView: UIView {
    // MARK: Properties
    @IBInspectable var rating: Float = 0 {
        didSet {
            setStarsFor(rating: rating)
            didChangedStars?(rating)
        }
    }
    
    @IBInspectable var starColor: UIColor = UIColor.systemOrange {
        didSet {
            for starImageView in [hstack?.star1ImageView, hstack?.star2ImageView, hstack?.star3ImageView,
                                  hstack?.star4ImageView, hstack?.star5ImageView] {
                starImageView?.tintColor = starColor
            }
        }
    }
    
    @IBInspectable var starRoundingRawValue: Int {
        get {
            return starRounding.rawValue
        }
        set {
            starRounding = StarRounding(rawValue: newValue) ?? .roundToHalfStar
        }
    }
    
    @IBInspectable var isTouchEnabled: Bool = true
    
    var starRounding: StarRounding = .roundToHalfStar {
        didSet {
            setStarsFor(rating: rating)
        }
    }
    
    private var lastTouch: Date?
    private var fullStarImage: UIImage?
    private var halfStarImage: UIImage?
    private var emptyStarImage: UIImage?
    private var hstack: StarRatingStackView?
    var didChangedStars: ((Float) -> Void)?
    
    // MARK: Initializers
    convenience init(frame: CGRect, rating: Float, color: UIColor, starRounding: StarRounding) {
        self.init(frame: frame)
        setupView(rating: rating, color: color, starRounding: starRounding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(rating: self.rating, color: self.starColor, starRounding: self.starRounding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView(rating: 3.5, color: UIColor.systemOrange, starRounding: .roundToHalfStar)
    }
    
    // MARK: Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, isTouchEnabled else { return }
        touched(touch: touch, moveTouch: false)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, isTouchEnabled else { return }
        touched(touch: touch, moveTouch: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, isTouchEnabled else { return }
        touched(touch: touch, moveTouch: false)
    }
    
    // MARK: Methods
    private func setupView(rating: Float, color: UIColor, starRounding: StarRounding) {
        let bundle = Bundle(for: StarRatingStackView.self)
        let nib = UINib(nibName: "StarRatingStackView", bundle: bundle)
        guard let viewFromNib = nib.instantiate(
                withOwner: self, options: nil)[0] as? StarRatingStackView else { return }
        addSubview(viewFromNib)
        setupConstraints(of: viewFromNib)
        fullStarImage = UIImage(systemName: "star.fill")
        halfStarImage = UIImage(systemName: "star.lefthalf.fill")
        emptyStarImage = UIImage(systemName: "star")
        hstack = viewFromNib
        starColor = color
        self.rating = rating
        self.starRounding = starRounding
        isMultipleTouchEnabled = false
        hstack?.isUserInteractionEnabled = false
    }
    
    private func setupConstraints(of viewFromNib: StarRatingStackView) {
        viewFromNib.translatesAutoresizingMaskIntoConstraints = false
        viewFromNib.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewFromNib.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setStarsFor(rating: Float) {
        let starImageViews = [hstack?.star1ImageView,
                              hstack?.star2ImageView,
                              hstack?.star3ImageView,
                              hstack?.star4ImageView,
                              hstack?.star5ImageView]
        for index in 1...5 {
            let iFloat = Float(index)
            switch starRounding {
            case .roundToHalfStar:
                starImageViews[index - 1]!.image = rating >= iFloat - 0.25 ? fullStarImage :
                    (rating >= iFloat - 0.75 ? halfStarImage : emptyStarImage)
            case .ceilToHalfStar:
                starImageViews[index - 1]!.image = rating > iFloat - 0.5 ? fullStarImage :
                    (rating > iFloat - 1 ? halfStarImage : emptyStarImage)
            case .floorToHalfStar:
                starImageViews[index - 1]!.image = rating >= iFloat ? fullStarImage :
                    (rating >= iFloat - 0.5 ? halfStarImage : emptyStarImage)
            case .roundToFullStar:
                starImageViews[index - 1]!.image = rating >= iFloat - 0.5 ? fullStarImage : emptyStarImage
            case .ceilToFullStar:
                starImageViews[index - 1]!.image = rating > iFloat - 1 ? fullStarImage : emptyStarImage
            case .floorToFullStar:
                starImageViews[index - 1]!.image = rating >= iFloat ? fullStarImage : emptyStarImage
            }
        }
    }
    
    private func touched(touch: UITouch, moveTouch: Bool) {
        let canTouch = !moveTouch || lastTouch == nil || lastTouch!.timeIntervalSince(Date()) < -0.1
        guard canTouch else { return }
        guard let hStack = hstack else { return }
        let touchX = touch.location(in: hStack).x
        let ratingFromTouch = 5 * touchX / hStack.frame.width
        var roundedRatingFromTouch: Float!
        switch starRounding {
        case .roundToHalfStar, .ceilToHalfStar, .floorToHalfStar:
            roundedRatingFromTouch = Float(round(2 * ratingFromTouch) / 2)
        case .roundToFullStar, .ceilToFullStar, .floorToFullStar:
            roundedRatingFromTouch = Float(round(ratingFromTouch))
        }
        rating = roundedRatingFromTouch
        lastTouch = Date()
    }
}
