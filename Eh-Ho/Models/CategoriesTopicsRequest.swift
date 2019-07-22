//
//  CategoriesTopicsRequest.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 22/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct CategoriesTopicsRequest: APIRequest{
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String]{
        return [:]
    }
    
    var body: [String : Any]{
        return [:]
    }
    
    var headers: [String : String]{
        return [:]
    }
    
    typealias Response = CategoriesTopicsResponse
    
    
}

