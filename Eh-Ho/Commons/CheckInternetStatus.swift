//
//  InternetStatus.swift
//  Eh-Ho
//
//  Created by Pere Josep Ferrer Ventura on 21/09/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation
import Network

@available(iOS 12.0, *)
class CheckInternetStatus {
    
    let monitor = NWPathMonitor()
    
    func checkConnetionStatus(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("La conexión a internet está activada")
                networkStatus = true
            }else{
                networkStatus = false
                print("La conexión a internet está desactivada")
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}

