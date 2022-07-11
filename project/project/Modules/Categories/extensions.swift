//
//  extensions.swift
//  project
//
//  Created by Rafael Shamsutdinov on 08.07.2022.
//

import UIKit

extension UIView{
    func makeShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
