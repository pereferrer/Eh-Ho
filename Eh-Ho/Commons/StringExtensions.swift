//
//  StringExtensions.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

extension String{
    func deleteHtmlTags()->String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
