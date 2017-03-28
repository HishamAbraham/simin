//
//  Detail.swift
//  simin
//
//  Created by Hisham Abraham on 3/26/17.
//  Copyright © 2017 Hisham Abraham. All rights reserved.
//

import Foundation
class SiminContact: NSObject {
    var type: String
    var contact: String
    
    init(type: String, contact: String) {
        self.type = type
        self.contact = contact
        super.init()
    }
    
}
