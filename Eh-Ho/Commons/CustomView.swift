//
//  CustomView.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 22/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
