//
//  NotRegisteredTableViewCell.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 28/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit



class NotRegisteredTableViewCell: UITableViewCell {

    @IBOutlet weak var scrollPeople: UIScrollView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.scrollPeople.contentSize = CGSize(width: 900, height: 900)
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
