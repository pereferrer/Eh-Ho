//
//  ApiErrorResponse.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 25/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct ApiErrorResponse: Codable, Error {
    let errors: [String]
    let action: String?
}
