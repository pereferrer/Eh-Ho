//
//  imageExtensions.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 21/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

extension UIImageView {

   func roundImage() {
      let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
