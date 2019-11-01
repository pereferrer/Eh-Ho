//
//  SuggestedTopicsTableViewCell.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 29/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class SuggestedTopicsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.profileImage.roundImage()
    }
    
}
