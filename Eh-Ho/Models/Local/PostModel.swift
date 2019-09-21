//
//  PostModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 20/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostModel {
    
    var id:Int = -1
    var title: String = ""
    
    convenience init(id: Int = -1, title:String){
        self.init()
        
        self.id = id
        self.title = title
    }
}
