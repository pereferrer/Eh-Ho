//
//  DateExtensions.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 21/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

extension Date{
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: Date()).minute ?? 0
    }
}
