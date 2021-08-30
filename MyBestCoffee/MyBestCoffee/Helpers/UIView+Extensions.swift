//
//  UIView+Extensions.swift
//  MyBestCoffee
//
//  Created by Pedro Gabriel on 29/08/21.
//

import UIKit

extension UIView {
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil) else {
            fatalError("Missing expected nib named: \(name)")
        }
        guard let view = nib.first as? Self else {
            fatalError("View of type \(Self.self) not found in \(nib)")
        }
        return view
    }
}
