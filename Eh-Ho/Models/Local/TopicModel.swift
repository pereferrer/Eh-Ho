//
//  TopicModel.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 20/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicModel {
    
    var id:Int = -1
    var title: String = ""
    var visits:Int = 0
    
    convenience init(id: Int = -1, title:String, visits:Int){
        self.init()
        
        self.id = id
        self.title = title
        self.visits = visits
    }
}
